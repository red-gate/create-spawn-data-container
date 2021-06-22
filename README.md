# Create Spawn Data Container Action

This action is part of a suite of Github Actions for [Spawn](https://spawn.cc), a service for provisioning cloud hosted, ephemeral databases for development and CI.

See the [Spawn docs](https://docs.spawn.cc/cicd/github-actions) for an example workflow that uses this action.

## Inputs

| Name            | Description                                                                           | Default | Required |
| --------------- | ------------------------------------------------------------------------------------- | ------- | -------- |
| dataImage       | The data image identifier (name, or numeric ID) to create a data container from       | N/A     | Yes      |
| lifetime        | The lifetime of the data container before it is automatically deleted.                | 73h     | No       |
| additionalArgs  | Any additional arguments or flags to `spawnctl`. These will be appended to the end    | ''      | No       |

## Outputs

| Name                  | Description                                                                           |
| --------------------- | ------------------------------------------------------------------------------------- |
| dataContainerName     | The name of the newly created data container                                          |
| dataContainerHost     | The host on which the new data container runs                                         |
| dataContainerPort     | The port on which the new data container listens                                      |
| dataContainerUsername | The username for the new data container                                               |
| dataContainerPassword | The password for the new data container                                               |

## Authentication

**All** operations require the use of a [Spawn access token](https://spawn.cc/docs/spawnctl-accesstoken-create).

This is expected to be provided to all actions through a `SPAWNCTL_ACCESS_TOKEN` environment variable. **This should be provided via a [GitHub Secret](https://docs.github.com/en/actions/reference/encrypted-secrets)**.
