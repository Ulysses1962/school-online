var ThematicPlan = React.createClass({
  getInitialState() {
    return {
      thematic_plan: this.props.thematic_plan
    }
  },

  render() {
    return (
      <tr>
        <td>{this.state.thematic_plan.name}</td>
        <td>{this.state.thematic_plan.academic_class}</td>
        <td>{this.state.thematic_plan.academic_parallel}</td>
        <td>{this.state.thematic_plan.theme_name}</td>
      </tr>
    );
  }
});