var ThematicPlans = React.createClass ({
  getInitialState() {
    return {
      thematic_plans: this.props.thematic_plans,
      thematic_plan: {
        school_id: '',
        subject_id: '',
        academic_class: '',
        academic_parallel: '',
        theme_name: '' 
      },
      errors: {}
    }
  }, 

  render() {
    var Options = this.props.subjects, 
        MakeOption= function(x) {
          return <option value={x.id}>{x.name.concat([' ', x.level.toString()])}</option>
        };    
    thematic_plans = this.props.thematic_plans.map( function(thematic_plan) {
      return (
        <ThematicPlan thematic_plan = {thematic_plan} key = {thematic_plan.id} />
      );  
    });
    return (
      <div id="thematic-plans-list" className="panel panel-primary">
        <div className="panel-heading">ТЕМАТИЧНІ ПЛАНИ</div>
        <div className="panel-body">
          <table className="table table-stripped">
            <thead>
              <tr>
                <th>Предмет</th>
                <th>Клас</th>
                <th>Паралель</th>
                <th>Назва теми</th>
              </tr>
            </thead>
            <tbody>
              {thematic_plans}
              <tr>
                <td>
                  <select onChange={this.handleSubjectId}>{Options.map(MakeOption)}</select>
                </td>
                <td>
                </td>
                <td>
                </td>
                <td>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div> 
    );
  }
});