-- 初始化建表SQL语句

create table sys_namespace
(
    id            int auto_increment comment '主键id',
    create_time   datetime     not null comment '创建时间',
    creator       varchar(255) not null comment '创建人',
    modifier      varchar(255) null comment '修改人',
    modified_time datetime     null comment '修改时间',
    user_id       int          not null comment '用户id',
    code          varchar(255) not null comment 'namespace编码',
    name          varchar(255) not null comment '名称',
    description   varchar(255) null comment '描述',
    auth          varchar(2)   not null comment '是否开启鉴权，Y-是，N-否',
    primary key (id, name)
)
    comment '命名中心表';

create index IDX_NAMESPACE_USER
    on sys_namespace (user_id, code);

create table sys_namespace_user
(
    id            int auto_increment comment '主键id'
        primary key,
    create_time   datetime     not null comment '创建时间',
    creator       varchar(255) not null comment '创建人',
    modifier      datetime     null comment '修改人',
    modified_time varchar(255) null comment '修改时间',
    user_id       int          not null comment '用户id',
    namespace_id  int          not null comment '命名空间id',
    account       varchar(255) not null comment '开放鉴权账号'
)
    comment '命名空间鉴权用户关联信息表';

create table sys_service_instance
(
    id             int auto_increment comment '主键id'
        primary key,
    create_time    datetime                    not null comment '创建时间',
    creator        varchar(255)                not null comment '创建人',
    modifier       varchar(255)                null comment '修改人',
    modified_time  datetime                    null comment '修改时间',
    user_id        int                         not null comment '用户id',
    service_name   varchar(255)                not null comment '服务名称',
    title          varchar(255)                not null comment '服务中文名称',
    namespace_id   int                         not null comment '空间id',
    namespace_code varchar(255)                not null comment '空间编码',
    type           varchar(255)                not null comment '类型，manual-手动，auto-自动',
    spec_url       varchar(1000)               null comment '数据源地址',
    spec_category  varchar(255)                null comment '请求类型,http,editor,file',
    spec_type      varchar(255)                not null comment '规范类型，Swagger2、OpenAPI3',
    spec_content   longtext                    not null comment '规范内容',
    service_status varchar(255)                null comment '服务状态，online-在线，dead-下线',
    description    varchar(255)                null comment '描述',
    debug_host     varchar(255)                null comment '调试地址，可修改',
    spec_mode      varchar(255) default 'json' not null comment 'spec内容规范模式，json、yaml'
)
    comment '接口注册中心信息表';

create table sys_user
(
    id              int auto_increment comment '主键id'
        primary key,
    create_time     datetime                not null comment '创建时间',
    creator         varchar(255)            not null comment '创建人',
    modifier        varchar(255)            null comment '修改人',
    modified_time   datetime                null comment '修改时间',
    account         varchar(255)            not null comment '账号',
    password        varchar(255)            not null comment '密码',
    salt            varchar(255)            not null comment '密码盐值',
    role            varchar(255)            not null comment '角色，admin-管理员，common-平台用户,doc-文档用户',
    token           varchar(255)            not null comment '系统账号api-key',
    last_login_time datetime                null comment '最后登录日期',
    last_login_ip   varchar(255)            null comment '最后登录ip地址',
    register_time   datetime                not null comment '注册日期',
    register_ip     varchar(255)            null,
    status          varchar(10) default 'Y' not null comment '是否禁用，Y-禁用，N-启用',
    domain          varchar(255)            not null comment '个性化域名',
    constraint IDX_USER_ACCUNION
        unique (account)
)
    comment '系统用户信息表';

-- 初始化管理员账号，用户名:admin@qq.com、密码：123456
INSERT INTO sys_user (create_time, creator, modifier, modified_time, account, password, salt, role, token, last_login_time, last_login_ip, register_time, register_ip, status, domain) VALUES ('2023-08-26 09:55:38', '0', null, '2023-09-14 21:24:14', 'admin@qq.com', '$2a$10$XfbiCSyK1C495T0baU/7veG0UxNSNJWo5SQ6CA9NwNTROHhJ/Yswa', '$2a$10$XfbiCSyK1C495T0baU/7ve', 'admin', 'OSDSmOuOlbf3yaxCo9yfGYezLOw9yGuoYyYZYz9ls00=', '2023-09-14 21:24:14', '0:0:0:0:0:0:0:1', '2023-08-26 09:55:38', '0:0:0:0:0:0:0:1', 'Y', 'admin');
