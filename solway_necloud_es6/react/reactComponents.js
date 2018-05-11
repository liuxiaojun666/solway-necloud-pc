const win = window;
win.reactComponent = (() => {

    // 设备状态颜色
    const deviceStatusColorMap = {
        '0': 'rgb(63, 173, 34)',
        '1': 'rgb(153, 153, 153)',
        '2': 'rgb(219, 65, 47)',
        '3': 'rgb(255, 153, 0)'
    };

    // 组串状态颜色
    const groupStringColorMap = {
        '0': 'transparent',
        '1': 'rgb(219, 65, 47)',
        '2': 'rgb(255, 153, 0)',
        '3': 'rgb(63, 173, 34)',
    };

    // 箱变
    const Xb = ({ data }) => (
        <div>
            <svg xmlns="http://www.w3.org/2000/svg" height="40" width="70" style={{ verticalAlign: 'middle' }}>
                <rect name="select" height="100%" width="100%" fill="rgba(6, 190, 189, .3)" style={{ display: 'none' }} />
                <g>
                    <rect stroke={deviceStatusColorMap[data.status]} height="30" width="60" y="5" x="5" fillOpacity="0.1" strokeWidth="1" fill={deviceStatusColorMap[data.status]} />
                    <ellipse stroke={deviceStatusColorMap[data.status]} ry="7" rx="7" id="svg_4" cy="24" cx="30" fillOpacity="0" strokeWidth="1" />
                    <ellipse stroke={deviceStatusColorMap[data.status]} ry="7" rx="7" id="svg_6" cy="16" cx="35" fillOpacity="0" strokeWidth="1" />
                    <ellipse stroke={deviceStatusColorMap[data.status]} ry="7" rx="7" id="svg_7" cy="24" cx="40" fillOpacity="0" strokeWidth="1" />
                </g>
                <rect name="shadow" height="100%" width="100%" fillOpacity="0.5" fill="#CCCCCC" style={{ display: 'none' }} />
            </svg>
            <span>{data.name}</span>
            <br />
            {data.children && data.children[0] && data.children.map(v => <Nbq key={v.id} data={v} />)}
        </div>
    );

    // 大逆变器
    const NbqD = ({ data }) => [
        <svg key={data.id} xmlns="http://www.w3.org/2000/svg" height="50" width="30" style={{ verticalAlign: 'middle' }}>
            <rect name="select" height="100%" width="100%" fill="rgba(6, 190, 189, .3)" style={{ display: 'none' }} />
            <g>
                <rect stroke={deviceStatusColorMap[data.status]} height="40" width="20" y="5" x="5" fillOpacity="0.1" strokeWidth="1" fill={deviceStatusColorMap[data.status]} />
                <line stroke={deviceStatusColorMap[data.status]} y2="45" x2="5" y1="5" x1="25" strokeWidth="1" />
                <line stroke={deviceStatusColorMap[data.status]} y2="14" x2="16" y1="14" x1="8" strokeWidth="1" />
                <path stroke={deviceStatusColorMap[data.status]} d="M15 35 Q 17 33, 19 35 T 23 35" fillOpacity="0" />
            </g>
            <rect name="shadow" height="100%" width="100%" fillOpacity="0.5" fill="#CCCCCC" style={{ display: 'none' }} />
        </svg>,
        <span>{data.name}</span>,
        <br key='br' />,
        ...data.children.map((v, i) => <Hlx key={v.id} data={v} />),
        <br key='br2' />
    ];

    // 汇流箱
    const Hlx = ({ data }) => (
        <svg xmlns="http://www.w3.org/2000/svg" height="47" width="56">
            <rect name="select" height="100%" width="100%" fill="rgba(6, 190, 189, .3)" style={{ display: 'none' }} />
            <g>
                <rect height="4" width="46" z="0" y="5" x="5" strokeOpacity="null" strokeWidth="1" stroke={deviceStatusColorMap[data.status]} fill={deviceStatusColorMap[data.status]} />
                <rect name="shadow" height="8" width="50" y="2" x="3" fillOpacity="0.5" fill="#CCCCCC" style={{ display: 'none' }} />
                {
                    data.statusData.statuFlags.slice(0, 10).map((v, i) => [
                        <rect height="10" width="1" z="1" y="12" x={5 + 5 * i} strokeOpacity="null" strokeWidth="1" stroke={groupStringColorMap[v]} fill={groupStringColorMap[v]} name="zuchuan" />,
                        data.statusData.shadowFlags[i] && <rect name="shadow" height="14" sz="1" width="5" y="10" x={3 + 5 * i} fillOpacity="0.5" fill="#CCCCCC" />
                    ])
                }
                {
                    data.statusData.statuFlags.slice(10, 20).map((v, i) => [
                        <rect height="10" width="1" z="1" y="25" x={5 + 5 * i} strokeOpacity="null" strokeWidth="1" stroke={groupStringColorMap[v]} fill={groupStringColorMap[v]} name="zuchuan" />,
                        data.statusData.shadowFlags[10 + i] && <rect name="shadow" height="14" sz="1" width="5" y="24" x={3 + 5 * i} fillOpacity="0.5" fill="#CCCCCC" />
                    ])
                }
            </g>
            <rect name="shadow" height="100%" width="100%" fillOpacity="0.5" fill="#CCCCCC" style={{ display: 'none' }} />
        </svg>
    );

    // 小逆变器
    const NbqHlx = ({ data }) => (
        <svg xmlns="http://www.w3.org/2000/svg" version="1.1" height="63" width="56">
            <rect name="select" height="100%" width="100%" fill="rgba(6, 190, 189, .3)" style={{ display: 'none' }} />
            <g type='nbq'>
                <rect stroke={deviceStatusColorMap[data.status]} x="5" y="5" width="46" height="14" fillOpacity='0.1' fill={deviceStatusColorMap[data.status]} />
                <line stroke={deviceStatusColorMap[data.status]} x1="5" y1="19" x2="51" y2="5" />
                <line stroke={deviceStatusColorMap[data.status]} x1="38" y1="14" x2="46" y2="14" />
                <path stroke={deviceStatusColorMap[data.status]} d='M10.17,9.7q2.09,2.31,4.19,0t4.19,0' fillOpacity='0' />
                <rect stroke={deviceStatusColorMap[data.status]} className='rectLayout' height='14' width='46' y='5' x='5' fillOpacity='0' fill={deviceStatusColorMap[data.status]} />
            </g>
            <g type='hlx'>
                {
                    data.list.slice(0, 10).map((v, i) => [
                        <rect key={i + '1'} fill={groupStringColorMap[v]} strokeOpacity='null' x={5 + 5 * i} y='24' width='1' height='14' stroke={groupStringColorMap[v]} name="zuchuan" />,
                        <rect key={i + '2'} name='shadow' fillOpacity='0.5' sz='0' x={3 + 5 * i} y='22' width='5' height='18' fill="#CCCCCC" style={{ display: 'none' }} />
                    ])
                }
                {
                    data.list.slice(10, 20).map((v, i) => [
                        <rect key={i + '1'} fill={groupStringColorMap[v]} strokeOpacity='null' x={5 + 5 * i} y='44' width='1' height='14' stroke={groupStringColorMap[v]} name="zuchuan" />,
                        <rect key={i + '2'} name='shadow' fillOpacity='0.5' sz='0' x={3 + 3 * i} y='42' width='5' height='18' fill="#CCCCCC" style={{ display: 'none' }} />
                    ])
                }
            </g>
        </svg>
    );

    // 逆变器 判断  大逆 or 小逆
    const Nbq = ({ data }) => data.hasJb === '1' ? <NbqHlx data={data} /> : <NbqD data={data} />;

    return {
        Xb,
        NbqD,
        Hlx,
        NbqHlx,
        Nbq
    };
})();