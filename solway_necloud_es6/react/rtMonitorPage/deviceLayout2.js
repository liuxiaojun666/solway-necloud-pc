const Xb = ({ data }) => {
    return (
        <div>
            <svg xmlns="http://www.w3.org/2000/svg" height="40" width="70">
                <rect name="select" height="100%" width="100%" fill="rgba(6, 190, 189, .3)" style={{ display: 'none' }} />
                <g>
                    <rect stroke="#3fad22" height="30" width="60" y="5" x="5" fillOpacity="0.1" strokeWidth="1" fill="#3fad22" />
                    <ellipse stroke="#3fad22" ry="7" rx="7" id="svg_4" cy="24" cx="30" fillOpacity="0" strokeWidth="1" />
                    <ellipse stroke="#3fad22" ry="7" rx="7" id="svg_6" cy="16" cx="35" fillOpacity="0" strokeWidth="1" />
                    <ellipse stroke="#3fad22" ry="7" rx="7" id="svg_7" cy="24" cx="40" fillOpacity="0" strokeWidth="1" />
                </g>
                <rect name="shadow" height="100%" width="100%" fillOpacity="0.5" fill="#CCCCCC" style={{ display: 'none' }} />
            </svg>
            <br />
            {data.list.map(v => <Nbq key={v.id} data={v} />)}
        </div>
    );
};

const NbqD = ({ data }) => {
    return [
        <svg key={data.id} xmlns="http://www.w3.org/2000/svg" height="50" width="30">
            <rect name="select" height="100%" width="100%" fill="rgba(6, 190, 189, .3)" style={{ display: 'none' }} />
            <g>
                <rect stroke="#3fad22" height="40" width="20" y="5" x="5" fillOpacity="0.1" strokeWidth="1" fill="#3fad22" />
                <line stroke="#3fad22" y2="45" x2="5" y1="5" x1="25" strokeWidth="1" />
                <line stroke="#3fad22" y2="14" x2="16" y1="14" x1="8" strokeWidth="1" />
                <path stroke="#3fad22" d="M15 35 Q 17 33, 19 35 T 23 35" fillOpacity="0" />
            </g>
            <rect name="shadow" height="100%" width="100%" fillOpacity="0.5" fill="#CCCCCC" style={{ display: 'none' }} />
        </svg>,
        <br key='br' />,
        // ...data.list.map((v, i) => <Hlx key={v + i} data={v} />)
    ];
};

const Hlx = ({ data }) => {
    return (
        <svg xmlns="http://www.w3.org/2000/svg" height="47" width="56">
            <rect name="select" height="100%" width="100%" fill="rgba(6, 190, 189, .3)" style={{ display: 'none' }} />
            <g>
                <rect height="4" width="46" z="0" y="5" x="5" strokeOpacity="null" strokeWidth="1" stroke="#3fad22" fill="#3fad22" />
                <rect name="shadow" height="8" width="50" y="2" x="3" fillOpacity="0.5" fill="#CCCCCC" style={{ display: 'none' }} />
                {
                    data.list.slice(0, 10).map((v, i) => [
                        <rect height="10" width="1" z="1" y="12" x={5 + 5 * i} strokeOpacity="null" strokeWidth="1" stroke="#3fad22" fill="#3fad22" name="zuchuan" />,
                        <rect name="shadow" height="14" sz="1" width="5" y="10" x={3 + 5 * i} fillOpacity="0.5" fill="#CCCCCC" style={{ display: 'none' }} />
                    ])
                }
                {
                    data.list.slice(10, 20).map((v, i) => [
                        <rect height="10" width="1" z="1" y="25" x={5 + 5 * i} strokeOpacity="null" strokeWidth="1" stroke="#3fad22" fill="#3fad22" name="zuchuan" />,
                        <rect name="shadow" height="14" sz="1" width="5" y="24" x={3 + 5 * i} fillOpacity="0.5" fill="#CCCCCC" style={{ display: 'none' }} />
                    ])
                }
            </g>
            <rect name="shadow" height="100%" width="100%" fillOpacity="0.5" fill="#CCCCCC" style={{ display: 'none' }} />
        </svg>

    );
};

const NbqHlx = ({ data }) => {
    return (
        <svg xmlns="http://www.w3.org/2000/svg" version="1.1" height="63" width="56">
            <rect name="select" height="100%" width="100%" fill="rgba(6, 190, 189, .3)" style={{ display: 'none' }} />
            <g type='nbq'>
                <rect stroke='#3fad22' x="5" y="5" width="46" height="14" fillOpacity='0.1' fill='#3fad22' />
                <line stroke='#3fad22' x1="5" y1="19" x2="51" y2="5" />
                <line stroke='#3fad22' x1="38" y1="14" x2="46" y2="14" />
                <path stroke='#3fad22' d='M10.17,9.7q2.09,2.31,4.19,0t4.19,0' fillOpacity='0' />
                <rect stroke='#3fad22' className='rectLayout' height='14' width='46' y='5' x='5' fillOpacity='0' fill='#3fad22' />
            </g>
            <g type='hlx'>
                {
                    data.list.slice(0, 10).map((v, i) => [
                        <rect key={i + '1'} fill='#3FAD22' strokeOpacity='null' x={5 + 5 * i} y='24' width='1' height='14' stroke='#3fad22' name="zuchuan" />,
                        <rect key={i + '2'} name='shadow' fillOpacity='0.5' sz='0' x={3 + 5 * i} y='22' width='5' height='18' fill="#CCCCCC" style={{ display: 'none' }} />
                    ])
                }
                {
                    data.list.slice(10, 20).map((v, i) => [
                        <rect key={i + '1'} fill='#3FAD22' strokeOpacity='null' x={5 + 5 * i} y='44' width='1' height='14' stroke='#3fad22' name="zuchuan" />,
                        <rect key={i + '2'} name='shadow' fillOpacity='0.5' sz='0' x={3 + 3 * i} y='42' width='5' height='18' fill="#CCCCCC" style={{ display: 'none' }} />
                    ])
                }
            </g>
        </svg>
    )
};

const Nbq = ({ data }) => {
    return data.hasJb ? <NbqHlx data={data} /> : <NbqD data={data} />;
};

ajaxData({
    realDataBInverter: {
        name: 'GETRealDataBInverter',
        data: {},
        later: true
    },
    selectByConditionMap: {
        name: 'GETselectByConditionMap',
        data: {},
        later: true
    },
}, {})('DeviceLayout2Ctrl', ['$scope', 'myAjaxData', '$interval'], ($scope, myAjaxData, $interval) => {

    class Root extends React.Component {
        state = {
            data: [
                {
                    id: 1,
                    status: 1,
                    list: [
                        {
                            id: 11,
                            status: 0,
                            list: [0, 1, 0, 1, 1, 1, 1, 1, 1, 2, 23, 4, 54, 6]
                        }
                    ]
                }, {
                    id: 2,
                    status: 2,
                    list: [

                    ]
                },
            ]
        }
        componentDidMount() {
            let timer = $interval(() => {
                if (this.state.data.length > 2000) {
                    $interval.cancel(timer);
                    timer = null
                }
                this.setState({
                    data: [
                        ...this.state.data,
                        {
                            id: Math.random() * 1000,
                            list: []
                        }
                    ]
                });
            }, 100);
        }
        render() {
            return this.state.data.map(v => (
                <div key={v.id} style={{ float: 'left', width: '25%' }}>
                    <Xb data={v} />
                </div>
            ));
        }
    }
    ReactDOM.render(
        <Root />,
        document.getElementById('deviceLayout')
    );
});