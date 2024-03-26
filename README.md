# babilema-action
An action to statically generate a blog based on your GitHub issues.

You can find more information about the actual static generator on [Babilema's GitHub repository](https://github.com/ByteBakersCo/babilema).

## Usage
This action will make use of Babilema to generate the blog but you need to push them to your repo yourself.  
You might want to consider [stefanzweifel/git-auto-commit Action](https://github.com/stefanzweifel/git-auto-commit-action) to do that.

### Inputs
```yaml
  github_token:
    description: 'GitHub token for authentication'
    required: true

  config:
    description: 'The path to the configuration file'
    required: false
    default: ${{ github.workspace }}/.babilema.toml
```

`${{ github.workspace }}` is the root directory of your repository.  

### Example usage
```yaml
name: Generate blog
on: pull_request

jobs:
  generate_blog:
    runs-on: ubuntu-latest

    steps:
    # Make sure to checkout the repository first
    # This is required for the action to be able to access your templates
    # and push the generated files
    - name: 'Check out code'
      uses: actions/checkout@v4

    - name: 'Generate blog'
    uses: ByteBakersCo/babilema-action@v1
    with:
      github_token: ${{ secrets.GITHUB_TOKEN }}
      config: 'path/to/config.toml' # Optional

    - name: 'Auto committing generated files'
      uses: stefanzweifel/git-auto-commit-action@v4
      with:
        commit_message: "ci: auto commit generated files"
        branch: ${{ github.head_ref }} # Read the actionn's documentation to see how to use this
```
