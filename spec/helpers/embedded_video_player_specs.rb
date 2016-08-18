require 'rails_helper'
require 'pry'

describe MartianComponents::ComponentsHelper do
    describe '#embedded_video_player' do
      let(:helper_output) { helper.embedded_video_player('id7890') }

      it 'Check if the main div exist and your class name' do
        expect(helper_output).to have_css('div.embedded-video-player-wrapper')
      end

      # Replace the name of the class id of the instance.
      it 'Check if the poster have a div, a class name and the correct video id' do
        expect(helper_output).to have_css('div.embedded-video-player-poster[style="background-image: url(\'http://img.youtube.com/vi/id7890/hqdefault.jpg\')"]')
      end

      it 'Check the placeholder id and class' do
        expect(helper_output).to have_css('div.embedded-video-player-placeholder')
        expect(helper_output).to have_selector('svg', 'embedded-video-player-wrapper')
      end

      it 'Check if svg file element exist, and detect your id' do
        expect(helper_output).to have_css('svg')
        expect(helper_output).to have_selector('div', 'embedded-video-Qtueil_91J0')
      end
  end
end
