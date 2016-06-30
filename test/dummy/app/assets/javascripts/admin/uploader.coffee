class @Admin.Uploader
  @autoInit: ->
    $('.fileinput-button input').each (i, el) => new @($(el))

  constructor: (@input) ->
    @form             = @input.parents('form')
    @hint             = $('~ .inline-hints', @input)
    @placeholder      = $('.placeholder', @hint)
    @media            = $('img, video', @hint)
    @remote_url_input = @input.parents('.fileinput-button')
      .siblings("[id*='remote_file_url_input']").find('input')

    @adjustInputSize()

    @input.S3FileField
      dropZone: @input
      add:      @onAdd
      done:     @onDone
      fail:     @onFail
      always:   @onAlways
      progress: @onProgress

  adjustInputSize: ->
    @hint.imagesLoaded =>
      @input.css
        height: @hint.outerHeight()
        width:  @hint.outerWidth()
        top:    @input.parent().css('padding-top')
        left:   @input.parent().css('padding-left')

  onAdd: (ev, data) =>
    $('body').css('height', $(document).height()) # Prevent page bounce (not SEO!)

    @placeholder.hide()
    @hint.addClass('uploading')
    data.submit()

  onDone: (ev, data) =>
    @placeholder.hide()
    @remote_url_input.val data.result.url

    if @form.data('autosave')
      @input.trigger('change') # Trigger autosave
      @hint.addClass('processing')
    else
      @media.attr('src', data.result.url)

  onFail: (ev, data) =>
    @placeholder.show() unless @media.attr('src').length

  onAlways: (ev, data) =>
    @hint.removeClass('uploading')
    @adjustInputSize()
    $('body').css('height', 'auto') # Prevent page bounce (not SEO!)

  onProgress: (ev, data) =>
    progress = parseInt(data.loaded / data.total * 100, 10)
    @hint.attr('data-content', "#{progress}%")
