window.VIMEditorDefaults =
  cursorColor: 'black',
  cursorWidth: 9,
  cursorHeight: 18,
  cursorLeft: 0,
  cursorTop: 0

window.VIMEditorActions =
  keypressHandler: (e) ->
    e = e || window.event
    console.log e.keyCode
    keyCodeStr = String.fromCharCode(e.keyCode)
    switch keyCodeStr
      when "k" then (-> #up
        VIMEditorDefaults.cursorTop -= if VIMEditorDefaults.cursorTop == 0 then 0 else 1
        cursorTopMargin = VIMEditorDefaults.cursorTop * VIMEditorDefaults.cursorHeight
        $('#cursor').css 'marginTop', cursorTopMargin
      )()
      when "j" then (-> #down
        VIMEditorDefaults.cursorTop += 1
        cursorTopMargin = VIMEditorDefaults.cursorTop * VIMEditorDefaults.cursorHeight
        $('#cursor').css 'marginTop', cursorTopMargin
      )()
      when "l" then (-> #right
        VIMEditorDefaults.cursorLeft += 1
        cursorLeftMargin = VIMEditorDefaults.cursorLeft * VIMEditorDefaults.cursorWidth
        $('#cursor').css 'marginLeft', cursorLeftMargin
      )()
      when "h" then (-> #left
        VIMEditorDefaults.cursorLeft -= if VIMEditorDefaults.cursorLeft == 0 then 0 else 1
        cursorLeftMargin = VIMEditorDefaults.cursorLeft * VIMEditorDefaults.cursorWidth
        $('#cursor').css 'marginLeft', cursorLeftMargin
      )()
      when "x" then (-> #deletechar
        content = $('#vimEditor-content').html()
        content = content.split('')
        content.splice((if VIMEditorDefaults.cursorLeft == 0 then 0 else VIMEditorDefaults.cursorLeft-1), 1)
        $('#vimEditor-content').html content.join('')
      )()
      when "esc" then (->
        console.log 'ESC'
      )()
      when "i", "" then (-> #insert mode
        VIMEditor.mode = 'insert'
        $('#cursor').width('2px')
      )()
      else #insert text
        content = $('#vimEditor-content').html()
        content = content.split('')
        content.splice(VIMEditorDefaults.cursorLeft-1, 0, keyCodeStr)
        $('#vimEditor-content').html content.join('')

window.VIMEditor =
  init: (->
    #$('#cursor').css 'backgroundColor', VIMEditorDefaults.cursorColor # TODO
    setInterval (-> $('#cursor').toggle()), 500
    $(document).on 'keypress', VIMEditorActions.keypressHandler
  ),
  mode: 'normal'

jQuery ->
  VIMEditor.init()
