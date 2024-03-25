# babilema-action
An action to statically generate a blog based on your GitHub issues.

You can find more information about the actual static generator on [Babilema's GitHub repository](https://github.com/ByteBakersCo/babilema).

## Usage

### Inputs
```yaml
github_token:
  description: 'GitHub token for authentication'
  required: true

commit_message:
  description: 'The commit message to use when pushing the generated files'
  required: false
  default: 'ci: update blog'

config:
  description: 'The path to the configuration file'
  required: false
  default: '' # Default is set in Babilema's source code
```

### Example usage
```yaml
uses: ByteBakersCo/babilema-action@v1
with:
  github_token: ${{ secrets.GITHUB_TOKEN }}
  commit_message: 'generate blog'
  config: 'path/to/config.toml'
```
