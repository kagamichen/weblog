// import { getRequest} from './app'
// import home from '../components/home'
//
//
// export const initMenu = (router, store) => {
//   if (store.state.routes.length > 0) {
//     return;
//   }
//   getRequest("/security/menu").then(data => {
//     if (data) {
//       let fmtRoutes = formatRoutes(data);
//       console.log(fmtRoutes)
//       router.addRoutes(fmtRoutes);
//       store.commit('initRoutes', fmtRoutes);
//       store.dispatch('connect');
//     }
//   })
// }
// export const formatRoutes = (rou) => {
//   let fmRoutes = [];
//   // let list=routes.from(routes)
// // console.log(routes)
//   rou.data.forEach(router => {
//
//     // console.log(1)
//     let {
//       path,
//       component,
//       name,
//       meta,
//       iconCls,
//       children
//     } = router;
//     if (children && children instanceof Array) {
//       // children = formatRoutes(children);
//     }
//     // console.log(2)
//     let fmRouter = {
//       path: path,
//       name: name,
//       iconCls: iconCls,
//       meta: meta,
//       children: children,
//       // component(resolve) {
//       //       //
//       //       //   require(['../components/' + component + '.vue'], resolve);
//       //       // }
//       // component(resolve) {
//       //   let componentPath = ''
//       //   componentPath = component
//       //   require([`../components/${componentPath}.vue`], resolve)
//       // }
//
//     }
//     console.log(fmRouter.children)
//     fmRoutes.push(fmRouter);
//   })
//   console.log(fmRoutes)
//   return fmRoutes;
// }
