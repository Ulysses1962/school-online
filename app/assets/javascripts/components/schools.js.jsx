class SchoolList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      schools: this.props.schools, 
      editMode: false,
      currentSchool: null,
      fileName: ''
    };  

    this.handleToggleEditMode = this.handleToggleEditMode.bind(this);
    this.handleCancelEditMode = this.handleCancelEditMode.bind(this);
    this.handleSchoolUpdate = this.handleSchoolUpdate.bind(this);  
    this.prepareSchoolsList = this.prepareSchoolsList.bind(this);
    this.prepareSchoolForm = this.prepareSchoolForm.bind(this);
    this.handleImport = this.handleImport.bind(this);
    this.handleChange = this.handleChange.bind(this);
}

  handleImport(event) {
    event.preventDefault();
    var school_data = new FormData();
    school_data.append('school_data', $('#school_data')[0].files[0]);
    $.ajax({
      url: '/admin/import_school',
      method: 'POST',
      processData: false,
      contentType: false,
      data: school_data,  
      success: () => {
        alert('Дані успішно імпортовані');
        this.setState({fileName: ''});
      }
    });
  }

  handleChange(event) {
    event.preventDefault();
    this.setState({
      fileName: event.target.value.split(/(\\|\/)/g).pop()
    });
  }

  handleToggleEditMode(school) {
    this.setState({ 
      editMode: true, 
      currentSchool: school
    });
  }

  handleCancelEditMode() {
    this.setState({
      editMode: false
    });
 }

  handleSchoolUpdate(school, data) {
    index = this.state.schools.indexOf(school);
    schools = React.addons.update(this.state.schools, {$splice: [[index, 1, data]]});
    this.setState({
      schools: schools,
      editMode: false, 
      currentSchool: null
    });
    alert('Дані успішно збережені!');
  }

  prepareSchoolsList() {
    schools = this.state.schools.map((school) => 
      <SchoolInfo school = {school} key = {school.id} handleEdit = {this.handleToggleEditMode} />
    );

    return (
      <section>
        <table className="table table-hover">
          <thead>
            <tr>
              <th className="col-md-2">Код</th>
              <th className="col-md-4">Назва навчального закладу</th>
              <th className="col-md-1"></th>
              <th className="col-md-1"></th>
              <th className="col-md-1"></th>
            </tr>  
          </thead>
          <tbody>
            {schools}
          </tbody>
        </table>
        <form id="school" className="form-inline">
          <div className="col-md-3 upload-group">
            <div className="input-group">
              <label className="btn input-group-addon btn-primary">
                Browse..<input id="school_data" type="file" className="hidden" onChange={this.handleChange} />
              </label>
              <input type="text" id="file_name" className="form-control" value={this.state.fileName} />  
            </div>
          </div>
          <div className="col-md-4">    
            <button type="submit" className="btn btn-warning" onClick={this.handleImport}>Імпортувати</button> 
          </div>  
        </form>
      </section>   
    );
  }

  prepareSchoolForm() {
    school = this.state.currentSchool;
    return (
      <SchoolForm school = {school} key = {school.id} handleEdit = {this.handleSchoolEdit} handleCancel = {this.handleCancelEditMode} handleUpdate = {this.handleSchoolUpdate} />
    );
  }

  render() {
    let content = null;
    if (this.state.editMode) {
      content = this.prepareSchoolForm();
    } else {
      content = this.prepareSchoolsList();
    }

    return (
      <div id="schools-list" className="panel panel-primary">
        <div className="panel-heading">АДМІНІСТРУВАННЯ НАВЧАЛЬНИХ ЗАКЛАДІВ</div>
        <div className="panel-body">
          {content}
        </div>
      </div>
    );
  }
}