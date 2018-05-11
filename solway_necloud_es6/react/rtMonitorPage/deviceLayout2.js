ajaxData({
    
}, {})('DeviceLayout2Ctrl', ['$scope', 'myAjaxData', '$interval'], ($scope, myAjaxData, $interval) => {

    class Root extends React.Component {
        constructor(props) {
            super(props);
            this.getData = this.getData.bind(this);
            this.state = {
                data: []
            };
            this.getData();
        }
        
        componentDidMount() {
            
        }

        getData() {
            $.getJSON('tpl/rtMonitorPage/deviceLayout/1.json', data => this.setState({ data }))
        }
        
        render() {
            const { Xb, Nbq } = window.reactComponent;
            return this.state.data.map(v => (
                <div key={v.id} className="col-xs-4" style={{marginBottom: '50px'}}>
                    {v.deviceType === 1 ? <Xb data={v} /> : null}
                    {v.deviceType === 2 ? <Nbq data={v} /> : null}
                </div>
            ));
        }
    }
    ReactDOM.render(
        <Root />,
        document.getElementById('deviceLayout')
    );
});