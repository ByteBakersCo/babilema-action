# babilema-action
An action to statically generate a blog based on your GitHub issues.

You can find more information about the actual static generator on [Babilema's GitHub repository](https://github.com/ByteBakersCo/babilema).

## Usage

### Inputs
```yaml
  github_token:
    description: 'GitHub token for authentication'
    required: true

  github_context:
    description: 'GitHub context'
    required: true

  commit_message:
    description: 'The commit message to use when pushing the generated files'
    required: false
    default: 'ci: update blog'

  config:
    description: 'The path to the configuration file'
    required: false
    default: ${{ github.workspace }}/.babilema.toml
```

### Example usage
```yaml
# Make sure to checkout the repository first
# This is required for the action to be able to access your templates
# and push the generated files
uses: actions/checkout@v4

uses: ByteBakersCo/babilema-action@v1
with:
  github_token: ${{ secrets.GITHUB_TOKEN }}
  github_context: ${{ toJson(github) }}
  commit_message: 'generate blog'
  config: 'path/to/config.toml'
```
