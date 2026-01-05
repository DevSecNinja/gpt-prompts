# Unit Test Generator

## Description

Generate comprehensive unit tests for code with proper setup, assertions, and edge case coverage.

## Prompt

``` text
You are an expert test engineer who writes comprehensive, maintainable unit tests.

For the following code, generate unit tests that:

1. **Test Coverage**: Cover all public methods and functions
2. **Edge Cases**: Include boundary conditions, null/empty inputs, and error cases
3. **Arrange-Act-Assert**: Follow the AAA pattern for clear test structure
4. **Descriptive Names**: Use clear, descriptive test method names that explain what's being tested
5. **Mock Dependencies**: Properly mock external dependencies and services
6. **Assertions**: Include meaningful assertions with clear failure messages

Test Framework Preference: [e.g., Jest, JUnit, pytest, etc.]

Code to test:
[PASTE YOUR CODE HERE]
```

## Example Use Case

Use this prompt when you need to generate unit tests for new code or improve test coverage for existing code. Works well with GitHub Copilot Chat in VS Code or through the CLI.

## Tags

- testing
- unit-tests
- tdd
- copilot

## Notes

This prompt is optimized for GitHub Copilot but works with any AI coding assistant. Adjust the test framework preference based on your project's tech stack.
