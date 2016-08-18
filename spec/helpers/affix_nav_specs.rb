require 'rails_helper'
require 'pry'

describe MartianComponents::ComponentsHelper do
    describe '#affix_nav' do
      let(:helper_output) { helper.affix_nav('www.google.com.br') }

      it 'Fist test' do
        expect(helper_output).to have_css('div.navbar-header')
      end
  end
end
