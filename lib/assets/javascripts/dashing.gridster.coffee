# This file enables gridster integration (http://gridster.net/)
# Delete it if you'd rather handle the layout yourself.
# You'll miss out on a lot if you do, but we won't hold it against you.

Dashing.gridsterLayout = (positions) ->
  Dashing.customGridsterLayout = true
  positions = positions.replace(/^"|"$/g, '')
  positions = $.parseJSON(positions)
  widgets = $("[data-row]")
  maxRow = 1
  maxCol = 1
  numColumns = Dashing.numColumns || 1
  for widget, index in widgets
    if positions? and index < positions.length
      $(widget).attr('data-row', positions[index].row)
      $(widget).attr('data-col', positions[index].col)
      if positions[index].row > maxRow
        maxRow = positions[index].row
        maxCol = positions[index].col + 1
      else if positions[index].row == maxRow and positions[index].col >= maxCol
        maxCol = positions[index].col + 1
    else
      if maxCol > numColumns
        maxRow += 1
        maxCol = 1
      $(widget).attr('data-row', maxRow)
      $(widget).attr('data-col', maxCol)
      maxCol += 1

Dashing.getWidgetPositions = ->
  $(".gridster ul:first").gridster().data('gridster').serialize()

Dashing.showGridsterInstructions = ->
  newWidgetPositions = Dashing.getWidgetPositions()

  unless JSON.stringify(newWidgetPositions) == JSON.stringify(Dashing.currentWidgetPositions)
    Dashing.currentWidgetPositions = newWidgetPositions
    $('#save-gridster').slideDown()
    $('#gridster-code').text("
      <script type='text/javascript'>\n
      $(function() {\n
      \ \ Dashing.gridsterLayout('#{JSON.stringify(Dashing.currentWidgetPositions)}')\n
      });\n
      </script>
    ")

$ ->
  $('#save-gridster').leanModal()

  $('#save-gridster').click ->
    $('#save-gridster').slideUp()
