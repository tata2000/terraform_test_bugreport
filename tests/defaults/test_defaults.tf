terraform {
  required_providers {
    # Because we're currently using a built-in provider as
    # a substitute for dedicated Terraform language syntax
    # for now, test suite modules must always declare a
    # dependency on this provider. This provider is only
    # available when running tests, so you shouldn't use it
    # in non-test modules.
    test = {
      source = "terraform.io/builtin/test",
    }

  }
}

module "tested_module" {
  # source is always ../.. for test suite configurations,
  # because they are placed two subdirectories deep under
  # the main module directory.
  source = "../.."


  #Setting testing variables

}

# As with all Terraform modules, we can use local values
# to do any necessary post-processing of the results from
# the module in preparation for writing test assertions.
locals {

}


# The special test_assertions resource type, which belongs
# to the test provider we required above, is a temporary
# syntax for writing out explicit test assertions.
resource "test_assertions" "test_name" {
  # "component" serves as a unique identifier for this
  # particular set of assertions in the test results.
  component = "tested_component"

  # equal and check blocks serve as the test assertions.
  # the labels on these blocks are unique identifiers for
  # the assertions, to allow more easily tracking changes
  # in success between runs.


  equal "check_component" {
    description = "checking the created component"
    got         = module.tested_module.s3
    want        = "will_not_work"
  }

  equal "output_success" {
    description = "should fail test"
    got         = module.tested_module.result
    want        = "wrong"
  }
  equal "should_fail" {
    description = "should fail test"
    got         = "string"
    want        = "https"
  }
}

