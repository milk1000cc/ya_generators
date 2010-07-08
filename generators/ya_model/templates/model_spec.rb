# -*- coding: utf-8 -*-
require 'spec_helper'

describe <%= class_name %> do
  <%- if attributes.any? { |v| v.reference? } -%>
    <%- attributes.find_all { |v| v.reference? }.each do |a| -%>
  it { should belong_to(:<%= a.name %>) }
    <%- end -%>

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
