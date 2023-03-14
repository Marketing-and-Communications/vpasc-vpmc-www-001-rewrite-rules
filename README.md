# Lambda@Edge Rewrite Rules

Lambda@Edge rewrite rules, tests, and pipeline

## Usage Summary

Fork or clone this repository and modify *rules.json* file in the rules directory, then write tests in the tests directory. 
The repository should be configured to fail merge if merge tests fail. 

## Rules

Simply make modifications to the *rules.json* files in the rules directory in a branch called *development*

## Tests

There are two methods that you can use to create test rules. **You will need to
have Docker installed to run or generate tests locally.**

### Setting up the local testing environment
You should install Docker and Python 3.8+.

Additionally, you should ensure that you have the `jq` CLI utility installed.
On a Mac, you can install it with Homebrew:

```bash
$ brew install jq
```

Additionally, you should ensure that you have the `sam` CLI utility installed.
On a Mac, you can install it with Homebrew:

```bash
$ brew tap aws/tap
$ brew install aws-sam-cli
```

### Manually create the rule
You can edit the *tests/tests.json* file and add a testing rule yourself. You
should ensure that the rules remain in alphabetical order to make browsing the
tests easier. The easier way to do this is to automatically generate the rule,
which is explained in the next section.

### Automatically create the rule and edit it
You can run the *rewrite_tester.py* utility in the *tester* directory to generate
tests as follows:

```bash
$ python tester/rewrite_tester.py --test_path tests --debug --build_missing_tests --no_junit_results
```

**Note: The first time that you checkout and run this project you'll need to
build the Lambda. You can do that by adding the --build_sam flag as follows:**

```bash
$ python tester/rewrite_tester.py --test_path tests --debug --build_missing_tests --build_sam --no_junit_results
```

## Deployment Workflow

Deploying changes to the rewrite rules should follow this workflow:
1. Commit and push a new version with tests and an updated rules.json file to the *development* branch
2. Submit a PR to merge the changes to the *staging* branch
3. The merge is only possible if the tests pass
4. Perform manual checks on the staging site. Be aware that changes to the staging site rules will take time 
   (up to the rule cache time) to take effect
5. Submit a PR to merge changes to the *main* branch
6. The merge is only possible if the tests pass
7. Be aware that changes to the production site rules will take time (up to the rule cache time) to take effect
