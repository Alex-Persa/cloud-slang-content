#   (c) Copyright 2014 Hewlett-Packard Development Company, L.P.
#   All rights reserved. This program and the accompanying materials
#   are made available under the terms of the Apache License v2.0 which accompany this distribution.
#
#   The Apache License is available at
#   http://www.apache.org/licenses/LICENSE-2.0
#
####################################################
# Delete Docker images specified in the input.
#
# Inputs:
#   - host - Docker machine host
#   - port - optional - SSH port
#   - username - Docker machine username
#   - password - Docker machine password
#   - images - list of Docker images to be deleted - Format: space delimited
#   - privateKeyFile - optional - absolute path to private key file
#   - arguments - optional - arguments to pass to the command
#   - characterSet - optional - character encoding used for input stream encoding from target machine - Valid: SJIS, EUC-JP, UTF-8
#   - pty - optional - whether to use PTY - Valid: true, false
#   - timeout - optional - time in milliseconds to wait for command to complete
#   - closeSession - optional - if false SSH session will be cached for future calls during the life of the flow, if true the SSH session used will be closed - Valid: true, false
# Outputs:
#   - response - ID of the deleted images
#   - error_message - error message if exists
# Results:
#   - SUCCESS
#   - FAILURE
####################################################
namespace: io.cloudslang.docker.images

imports:
  ssh: io.cloudslang.base.remote_command_execution.ssh

flow:
  name: clear_docker_images
  inputs:
    - host
    - port:
        required: false
    - username
    - password
    - images
    - privateKeyFile:
        required: false
    - command:
        default: "'docker rmi ' + images"
        overridable: false
    - arguments:
        required: false
    - characterSet:
        required: false
    - pty:
        required: false
    - timeout:
        required: false
    - closeSession:
        required: false
  workflow:
    - clear_images:
        do:
          ssh.ssh_flow:
            - host
            - port
            - username
            - password
            - privateKeyFile:
                required: false
            - command
            - arguments:
                required: false
            - characterSet:
                required: false
            - pty:
                required: false
            - timeout:
                required: false
            - closeSession:
                required: false
            - agentForwarding:
                required: false
        publish:
            - return_result: returnResult
            - error_message: standard_err
  outputs:
    - reposnse: return_result
    - error_message: error_message
