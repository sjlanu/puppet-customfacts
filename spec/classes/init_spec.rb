require 'spec_helper'
describe 'customfacts' do
  context 'with default values for all parameters' do
    it { should contain_class('customfacts') }
  end
end
