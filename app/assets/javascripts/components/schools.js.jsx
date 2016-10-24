class SchoolList extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      editMode: false,
      currentSchool: null
    };  

    this.handleToggleEditMode = this.handleToggleEditMode.bind(this);
    this.handleCancelEditMode = this.handleCancelEditMode.bind(this);
    this.handleSchoolEdit = this.handleSchoolEdit.bind(this);  
    this.prepareSchoolsList = this.prepareSchoolsList.bind(this);
    this.prepareSchoolForm = this.prepareSchoolForm.bind(this);
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

  handleSchoolEdit(school) {
    this.setState({ 
      editMode: false, 
      currentSchool: null
    });
  }

  prepareSchoolsList() {
    schools = this.props.schools.map((school) => 
      <SchoolInfo school = {school} key = {school.id} handleEdit = {this.handleToggleEditMode} />
    );

    return (
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
    );
  }

  prepareSchoolForm() {
    school = this.state.currentSchool;
    return (
      <SchoolForm school = {school} key = {school.id} handleEdit = {this.handleSchoolEdit} handleCancelEditing = {this.handleCancelEditMode} />
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
        <div className="panel-heading">СПИСОК НАВЧАЛЬНИХ ЗАКЛАДІВ</div>
        <div className="panel-body">
          {content}
        </div>
      </div>
    );
  }
}