require 'spec_helper'
require 'generator_spec'
require 'generators/dashing/widget_generator'

describe Dashing::Generators::WidgetGenerator do

  arguments %w(test_widget)

  before do
    run_generator
  end

  after do
    `find #{Rails.root.join('app')} -name "test_widget.*" -delete`
  end

  it 'creates widget files' do
    assert_file Rails.root.join 'app/views/dashing/widgets/test_widget.html'
    assert_file Rails.root.join 'app/assets/javascripts/dashing/widgets/test_widget.coffee'
    assert_file Rails.root.join 'app/assets/stylesheets/dashing/widgets/test_widget.scss'
  end
end
