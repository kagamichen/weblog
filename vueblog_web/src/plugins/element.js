import Vue from 'vue'
import { Button, Message, Form, FormItem, Input, Container, Header, Aside, Main,
  Dropdown, DropdownItem, DropdownMenu, Menu, MenuItemGroup, MenuItem, Submenu
  , Col, Breadcrumb, Switch, Checkbox, CheckboxGroup, CheckboxButton, TimePicker, DatePicker, Cascader, Alert,Radio,RadioGroup,
  BreadcrumbItem, Card, Row, Table, TableColumn, Popover, Tag, Pagination, Select, Option, MessageBox }
  from 'element-ui'

Vue.use(Radio)
Vue.use(RadioGroup)
Vue.use(Button)
Vue.use(Alert)
Vue.use(Cascader)
Vue.use(Checkbox)
Vue.use(DatePicker)
Vue.use(TimePicker)
Vue.use(CheckboxGroup)
Vue.use(CheckboxButton)
Vue.use(Switch)
Vue.use(Select)
Vue.use(Option)
Vue.use(Pagination)
Vue.use(Table)
Vue.use(TableColumn)
Vue.use(Popover)
Vue.use(Tag)
Vue.use(FormItem)
Vue.use(Form)
Vue.use(Input)
Vue.use(Container)
Vue.use(Header)
Vue.use(Aside)
Vue.use(Main)
Vue.use(Dropdown)
Vue.use(DropdownItem)
Vue.use(DropdownMenu)
Vue.use(Menu)
Vue.use(MenuItemGroup)
Vue.use(MenuItem)
Vue.use(Submenu)
Vue.use(Submenu)
Vue.use(Col)
Vue.use(Breadcrumb)
Vue.use(BreadcrumbItem)
Vue.use(Card)
Vue.use(Row)

Vue.prototype.$message = Message
Vue.prototype.$confirm = MessageBox.confirm
