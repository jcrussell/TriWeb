require 'test_helper'

class WorkoutCommentTest < ActiveSupport::TestCase

  test "all fields must be set" do
    comment = WorkoutComment.new
    assert comment.invalid?
    assert comment.errors[:comment].any?
  end
end
