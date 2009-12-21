# -*- coding: utf-8 -*-
require 'spec_helper'

describe <%= class_name %> do
  <%- attributes.find_all { |v| v.reference? }.each do |a| -%>
  it 'は、特定の <%= a.name.classify %> に所属すること' do
    <%= a.name %> = Factory(:<%= a.name %>)
    <%= singular_name %> = Factory(:<%= singular_name %>, :<%= a.name %>_id => <%= a.name %>.id)
    <%= singular_name %>.<%= a.name %>.should == <%= a.name %>
  end

  <%- end -%>
  describe 'を作成するとき' do
    before do
      @attrs = Factory.attributes_for(:<%= singular_name %>)
      @creation = lambda { <%= class_name %>.create!(@attrs) }
    end

    it 'は、正常な値ならば作成できること' do
      @creation.should_not raise_error
    end
  end
end
