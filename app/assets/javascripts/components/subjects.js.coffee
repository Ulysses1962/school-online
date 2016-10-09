@Subjects = React.createClass
  getInitialState: ->
    subjects: @props.data
  getDefaultProps: ->
    subjects: []  
  updateRecord: (record, data) ->
    index = @state.subjects.indexOf record
    subjects = React.addons.update(@state.subjects, { $splice: [[index, 1, data]]})
    @replaceState subjects: subjects  
  render: ->
    React.DOM.h3
      className: ''
      'Subjects'
    React.DOM.table
      className: 'table table-stripped'
      React.DOM.thead null,
        React.DOM.tr null,
          React.DOM.th null, 'Subject name'
          React.DOM.th null, 'Level'
          React.DOM.th null, 'Actions'
      React.DOM.tbody null,
        for subject in @state.subjects
          React.createElement Subject, key: subject.id, subject: subject, handleEditRecord: @updateRecord       
