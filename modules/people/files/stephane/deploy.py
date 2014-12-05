import json
import argparse
import shutil
import os
import sys
import subprocess
import signal

def exit_gracefully(signum, frame):
  # Revert package.json
  if os.path.exists(os.path.join(os.getcwd(), 'package.json-original')):
    shutil.copy(os.path.join(os.getcwd(), 'package.json-original'), os.path.join(os.getcwd(), 'package.json'))
    os.remove('package.json-original')
  print "User terminiated deploy"
  sys.exit(0)

def setup_environment(environment):
  # Copy original package.json
  shutil.copy(os.path.join(os.getcwd(), 'package.json'), os.path.join(os.getcwd(), 'package.json-original'))

  # Read package.json and update environment
  package_file = open('package.json', 'r')
  package_json = json.loads(package_file.read())
  package_file.close()

  package_json['environment'] = environment

  package_file = open('package.json', 'w')
  package_file.write(json.dumps(package_json, indent=4))
  package_file.close()

def revert_environment():
  # Revert package.json
  shutil.copy(os.path.join(os.getcwd(), 'package.json-original'), os.path.join(os.getcwd(), 'package.json'))
  os.remove('package.json-original')

def clean_deploy_dir():
  # Delete the dist directory
  dist_dir = os.getcwd()
  dist_dir = dist_dir[:dist_dir.rfind('/')]
  try:
    print "#### Deleting dist directory at: %s" % dist_dir
    shutil.rmtree(os.path.join(dist_dir, 'dist'))
  except:
    print "#### Failed to delete dist directory at: %s" % dist_dir

def push_index(server):
  print "#### Pushing index files to server {}".format(server)
  command = "scp ../dist/index.html ../dist/index.gz.html ubuntu@{}:/var/www/goodrx-mobile/".format(server)
  # Push dist to server
  subprocess.check_output(
    [command],
    shell=True,
    stderr=subprocess.STDOUT)

def deploy_cmd(deploy_cmd):
  # push to s3 to build
  p = subprocess.Popen(
    ["grunt {}".format(deploy_cmd)],
    shell=True,
    stderr=subprocess.STDOUT)
  p.communicate()

def push_static():
  # push to s3 to build
  p = subprocess.Popen(
    ["grunt s3"],
    shell=True,
    stderr=subprocess.STDOUT)
  p.communicate()

def watch():
  print "starting watch"
  os.system("grunt watch -force")

def build():
  try:
    # Call grunt to build
    p = subprocess.Popen(
      ["grunt", "-force"],
      shell=True,
      stderr=subprocess.STDOUT)
    # for line in iter(p.stdout.readline, b''):
    #     print line,
    p.communicate()
  except Exception, e:
    print e
    revert_environment()

def bump_version(release):
  command = "grunt bump:{}".format(release)
  p = subprocess.Popen(
    [command],
    shell=True,
    stderr=subprocess.STDOUT)
  p.communicate()

def do_clean_build():
  try:
    # Call commands
    p = subprocess.Popen(
      ["rm", "-rf", "node_modules bower_components"],
      shell=True,
      stderr=subprocess.STDOUT)
    p.communicate()

    p = subprocess.Popen(
      ["npm", "install"],
      shell=True,
      stderr=subprocess.STDOUT)
    p.communicate()

    p = subprocess.Popen(
      ["bower", "cache", "clean"],
      shell=True,
      stderr=subprocess.STDOUT)
    p.communicate()

    p = subprocess.Popen(
      ["bower", "install"],
      shell=True,
      stderr=subprocess.STDOUT)
    p.communicate()
  except Exception, e:
    print e
    revert_environment()

def deploy():
  parser = argparse.ArgumentParser()
  parser.add_argument('environment', nargs=1, help="the environment to build for")
  parser.add_argument('release_type', nargs='*', default=['patch'], help="the type of release to deploy (possible values: patch, minor, major, prerelease) defaults to patch")
  # parser.add_argument('server', nargs=1, help="the server to push to")
  # parser.add_argument('--s3', '-s', action="store_true", dest="s3", help="do grunt s3 after build")
  parser.add_argument('--watch', '-w', action="store_true", dest="watch", help="do grunt watch after the deploy")
  parser.add_argument('--no-rebuild', '-r', action="store_true", dest="no_rebuild", help="do a deploy without rebuilding the original environment")
  parser.add_argument('--no-bump', '-b', action="store_true", dest="no_bump", help="do a deploy to the same version instead of bumping a version")
  parser.add_argument('--clean-build', '-cb', action="store_true", dest="clean_build", help="clean and then build")
  args = parser.parse_args()

  if args.release_type[0] not in ['patch', 'minor', 'major', 'prerelease']:
    print "Error: the release_type needs to be 'patch', 'minor', 'major' or 'prerelease' if specified"
    sys.exit(0)

  if not args.no_bump:
    bump_version(args.release_type[0])

  setup_environment(args.environment[0])

  try:
    if args.clean_build:
      do_clean_build()

    clean_deploy_dir()

    build()

    # if args.s3:
    #   push_static()
    cmd = None
    if args.environment[0] == 'production':
      cmd = 'deployProduction'
    elif args.environment[0] == 'staging':
      cmd = 'deployStaging'

    if cmd:
      deploy_cmd(cmd)

    revert_environment()

    if not args.no_rebuild:
      print "Rebuilding development grunt"

      clean_deploy_dir()

      build()

      if args.watch:
        watch()

  except Exception, e:
    print e
    revert_environment()

if __name__ == "__main__":
    signal.signal(signal.SIGINT, exit_gracefully)
    deploy()
