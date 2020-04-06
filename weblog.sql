/*
 Navicat Premium Data Transfer

 Source Server         : chen_mac
 Source Server Type    : MySQL
 Source Server Version : 80019
 Source Host           : localhost:3306
 Source Schema         : weblog

 Target Server Type    : MySQL
 Target Server Version : 80019
 File Encoding         : 65001

 Date: 06/04/2020 21:12:21
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `creationtime` date DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `column_id` int DEFAULT NULL,
  `body` text,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
BEGIN;
INSERT INTO `article` VALUES (1, 'Spring Boot+Vue前后端分离，如何避免前端页面 404', '2020-04-01', '陈登宝', 1, '<h2 id=\"1-职责划分\">1.职责划分</h2><p>在传统的前后端不分的开发中，权限管理主要通过过滤器或者拦截器来进行（权限管理框架本身也是通过过滤器链来实现功能），如果用户不具备某一个角色或者某一个权限，则无法访问某一个页面。</p><p>但是在前后端分离中，页面的跳转统统交给前端去做，后端只提供数据，这种时候，权限管理不能再按照之前的思路来。</p><p>首先要明确一点，前端是展示给用户看的，所有的菜单显示或者隐藏目的不是为了实现权限管理，而是为了给用户一个良好的体验（把用户没有权限的按钮隐藏起来，避免用户点击后提示 403，提高用户体验），不能依靠前端隐藏控件来实现权限管理，即数据安全不能依靠前端。</p><p>这就像普通的表单提交一样，前端做数据校验是为了提高效率，提高用户体验，后端才是真正的确保数据完整性。</p><p>所以，真正的数据安全管理是在后端实现的，后端在接口设计的过程中，就要确保每一个接口都是在满足某种权限的基础上才能访问，也就是说，不怕将后端数据接口地址暴露出来，即使暴露出来，只要你没有相应的角色/权限，也是访问不了的。</p><p>前端为了良好的用户体验，需要将用户不能访问的接口或者菜单隐藏起来。页面的跳转，按钮的隐藏/展示等等，统统在前端来实现。</p><h2 id=\"2-存在的问题\"><a href=\"http://www.javaboy.org/2020/0317/springboot-vue-404.html#2-%E5%AD%98%E5%9C%A8%E7%9A%84%E9%97%AE%E9%A2%98\" title=\"2.存在的问题\"></a>2.存在的问题</h2><p>当前后端分离之后，对于前端所承担的职责，大家可能会面临一个问题：如果用户直接在地址拦输入某一个页面的路径，怎么办？</p><p>此时，如果没有做任何额外的处理的话，用户确实可以通过直接输入某一个路径进入到系统中的某一个页面中，但是，不用担心数据泄露问题，因为没有相关的角色/权限，就无法访问相关的接口，即使进入到相关的页面，也看不到数据。</p><p>但是，如果用户非这样操作，进入到一个空白的页面，用户体验不好，冒出来一个空白页面，有的用户就手足无措了。</p><p>此时，我们可以使用 Vue 中的前置路由导航守卫，来监听页面跳转，如果用户想要去一个未获授权的页面，则直接在前置路由导航守卫中将之拦截下来，重定向到登录页，或者直接就停留在当前页，不让用户跳转，也可以顺手再给用户一点点未获授权的提示信息。</p><p>以 vhr 中的代码为例，我在 main.js 中定义了前置路由导航守卫：</p><figure id=\"code-1585739299962648\"><table><tbody><tr><td><pre>1<br>2<br>3<br>4<br>5<br>6<br>7<br>8<br>9<br>10<br>11<br>12<br></pre></td><td><pre>router.beforeEach((to, from, next) =&gt; {<br>    if (to.path == \'/\') {<br>        next();<br>    }else {<br>        if (window.sessionStorage.getItem(\"user\")) {<br>            initMenu(router, store);<br>            next();<br>        }else{<br>            next(\'/?redirect=\'+to.path);<br>        }<br>    }<br>})<br></pre></td></tr></tbody></table></figure><p>这个方法有点类似于 Java 中的过滤器，to 表示要去哪里，有点像 HttpServletResponse；from 表示从哪来，有点像 HttpServletRequest；next 表示一个请求继续向下执行的方法，有点类似于 FilterChain。</p><p>这里会监控到所有的页面路由/跳转，主要逻辑是这样：</p><ol><li>如果要去的地址是 ‘/‘，即要去的地方是登录页面，则直接执行 next 方法表示放行。</li><li>如果要去的地址不是 ‘/‘，那就要看用户是否登录了，如果已经登录了，则先初始化菜单，然后调用 next 方法继续向下走，想去哪去哪。</li><li>如果没有登录，则调用 next 方法，跳转路径是 ‘/‘，即回到登录页面，同时携带上一个 redirect 参数，这个是重定向的地址，这个参数的作用是这样：例如我本来输入 ‘/aa/bb’，结果因为没有登录，自动跳转到项目登录页面，当我登录成功后，自动跳回 ‘/aa/bb’。</li></ol><p>有这个配置之后，就不怕用户乱跳转了，如果没有登录随意输入一个地址，就会回到登录页面。</p><h2 id=\"3-404问题\"><a href=\"http://www.javaboy.org/2020/0317/springboot-vue-404.html#3-404%E9%97%AE%E9%A2%98\" title=\"3. 404问题\"></a>3. 404问题</h2><p>上面的配置还存在一个 404 问题。</p><p>在用户还没有登录的时候，如果他在浏览器输入一个不存在的地址，就会自动回到登录页面，这没有问题，但是用户如果已经登录了，在浏览器输入一个不存在的地址，这个时候就会发生 404，当你没做任何定义的时候，所谓的 404 页面其实就是一片空白。</p><p>要解决这个问题，很多小伙伴第一个思路就是能不能在前置路由导航守卫里边做一个判断，当你要跳转的时候，先去判断一个跳转的路径是否存在，如果存在再去跳转，否则就不去跳转。</p>');
INSERT INTO `article` VALUES (2, 'Spring Boot 要怎么学？', '2020-04-01', '张剑锋', 1, '<p><br></p><h2 id=\"1-Spring-Boot-是什么\">1.Spring Boot 是什么</h2><p>我们刚开始学习 JavaWeb 的时候，使用 Servlet/JSP 做开发，一个接口搞一个 Servlet ，很头大，后来我们通过隐藏域或者反射等方式，可以减少 Servlet 的创建，但是依然不方便。</p><p>再后来，我们引入 Struts2/SpringMVC 这一类的框架，来简化我们的开发 ，和 Servlet/JSP 相比，引入框架之后，生产力确实提高了不少，但是用久了，又发现了新的问题，即配置繁琐易出错，要做一个新项目，先搭建环境，环境搭建来搭建去，就是那几行配置，不同的项目，可能就是包不同，其他大部分的配置都是一样的。</p><p>Java 总是被人诟病配置繁琐代码量巨大，这就是其中一个表现。那么怎么办？Spring Boot 应运而生，Spring Boot 是 Pivotal 团队在 2013 年开始研发的一个基于 Spring 的全新框架，试图将 Spring 中臃肿的配置进行简化，使 Java 开发更加轻量与快速，这个框架非常活跃，官方也非常重视。</p><p>Spring Boot 主要提供了如下功能：</p><ol><li>为所有基于 Spring 的 Java 开发提供方便快捷的入门体验。</li><li>开箱即用，有自己自定义的配置就是用自己的，没有就使用官方提供的默认的。</li><li>提供了一系列通用的非功能性的功能，例如嵌入式服务器、安全管理、健康检测等。</li><li>绝对没有代码生成，也不需要XML配置。</li></ol><p>Spring Boot 的出现让 Java 开发又回归简单，因为确确实实解决了开发中的痛点，因此这个技术得到了非常广泛的使用，大概从 2017 年年初开始，Spring Boot 基本上面试必问，现在流行的 Spring Cloud 微服务也是基于 Spring Boot，因此，所有的 Java 工程师都有必要掌握好 Spring Boot。</p><p>从 Spring Boot 诞生的过程中，我们可以看到：</p><ol><li>Spring Boot 并非另起炉灶，而是在现有的 Spring 框架的基础上整出来的，它把 Spring 中繁琐的配置进行了简化。</li><li>Spring Boot 降低了 Spring 家族的使用门槛，使新手更易上手 Spring 框架。</li></ol><p>既然 Spring Boot 不是另起炉灶，那么 Spring Boot 学习要不要跳过 SSM 呢？听松哥来分析。</p><h2 id=\"2-要不要跳过-SSM\"><a href=\"http://www.javaboy.org/2020/0224/springboot-guide.html#2-%E8%A6%81%E4%B8%8D%E8%A6%81%E8%B7%B3%E8%BF%87-SSM\" title=\"2.要不要跳过 SSM\"></a>2.要不要跳过 SSM</h2><p>这是很多人问我的一个问题，我的建议是：<strong>不要</strong>。</p><p>Spring Boot 基于 Spring，简单且容易上手，很多人想当然的跳过 SSM 直接上 Spring Boot。但是当我们细究 Spring Boot 中的自动化配置、条件注解、Java 配置等东西时，实在找不出太多新鲜玩意，Java 配置是 Spring3 开始提供的，条件注解 也是 Spring 中的东西，很多很多，都是 Spring 中就有的，只不过这些东西在 Spring Boot 时代大放异彩。</p><p>也就是说，即使你跳过了 SSM 直接去学习 Spring Boot，实际上还是在学习 Spring 中的东西，那既然这样，我们还不如坐下来，老老实实把 Spring 过一遍。</p><p>各个领域的开发工程师其实都会面临类似的问题，学习了一些优秀的封装框架之后，还有没有必要去学习底层？当然有必要！因为底层的东西可以让你深刻的理解你目前用的这个东西，也能让你在出问题时快速解决掉问题。</p><p>其实无论你想搞什么技术，都要有牢固的基础知识，这些牢固的基础知识就像肥沃的土壤，可以孕育出各种不同技术方向的牛人，基础掌握好了，学什么框架都快。今天你跳过 SSM 直接学了 Spring Boot，假如有一天 Spring Boot 不行了，Pivotal 团队又基于 Spring 框架搞了一个新的框架出来，那你是不是又要去学一遍？但是如果你一开始就掌握了 Spring 的各种用法，无论基于它搞出来什么样的框架，你都能快速上手。更进一步，如果你研究透了 Spring 中的 AOP、Ioc/DI，你会发现很多框架大同小异，核心思想就是这些东西，那么你在学习 Spring 之外的框架，就会容易很多。</p><p><strong>如果你对 SSM 还不太熟悉的话，可以在公号后台分别回复&nbsp;<code>spring</code>、<code>springmvc</code>、<code>mybatis</code>&nbsp;获取松哥手敲 5 万余字的干货教程。</strong></p><h2 id=\"3-都要学哪些\"><a href=\"http://www.javaboy.org/2020/0224/springboot-guide.html#3-%E9%83%BD%E8%A6%81%E5%AD%A6%E5%93%AA%E4%BA%9B\" title=\"3.都要学哪些\"></a>3.都要学哪些</h2><p>那么 Spring Boot 学习都要学哪些东西呢？我这里列举了一个进阶路线：</p><ol><li>最基础的当然是 Spring/SpringMVC 相关的东西了。</li><li>搭配各种页面模版的使用，例如 Jsp/Thymeleaf/Freemarker/Groovy Templates 等。</li><li>和各种 SQL 数据库的整合，以及一些常见的数据持久化框架，例如 JdbcTemplate、MyBatis、Jpa 等。</li><li>和各种 NoSQL 数据库的整合，例如 Redis、MongoDB、Elasticsearch 等。</li><li>搭配安全管理相关的知识点，例如 Spring Security、Shiro 等。</li><li>缓存的使用，例如 JCache、Ehcache 等。</li><li>和消息中间件的搭配整合，如 ActiveMQ、RabbitMQ、Kafka 等。</li><li>数据校验/定时任务/邮件发送等。</li><li>各种监控的使用。</li><li>结合 WebSocket 的使用。</li><li>Spring Cloud 中相关组件。</li><li>…</li></ol><p>上面这些只是我列出来的一些比较常见的技术点，每个技术点都还可以延伸出很多其他的东西，大家可以结合自己的情况，按照顺序一个一个来学，这里边还涉及到很多第三方的框架，例如 Redis、MongoDB、RabbitMQ 等，Spring Boot 的出现只是让这些组件在和 Spring 家族的产品整合时变得更加方便，但是并不会简化这些组件原本的用法，所以，该学 Redis、该学 MongoDB、该学 RabbitMQ 等等，还是一个不能少。以 Redis 为例，学会了 Redis，学会了 Spring 整合 Redis，再回过头来看 Spring Boot 整合 Redis，那简直太 easy 了（<strong>大家在公众号后台回复 redis，有松哥手敲的 redis 教程</strong>）。</p><p>当然，学习 Spring Boot 最终我们还是奔着快速开发和微服务去的，所以，像 Docker、Spring Cloud 等技术，也是需要去了解一下的。</p><h2 id=\"4-怎么学\"><a href=\"http://www.javaboy.org/2020/0224/springboot-guide.html#4-%E6%80%8E%E4%B9%88%E5%AD%A6\" title=\"4.怎么学\"></a>4.怎么学</h2><p>Spring Boot 发展到今天，网上的资料和图书现在是越来越多了。在看资料学习的同时，大家也要留意以下几个点：</p><ol><li>多看源码。不同于其他全新的框架源码你可能会看懵了，由于 Spring Boot 是基于 Spring 的，所以只要你 Spring 基础扎实，看 Spring Boot 源码可以说是毫无压力。如果看 Spring Boot 源码觉得有压力，那可能你 Spring 基础不牢靠，这个时候不妨放下 Spring Boot，去复习下 Spring。</li><li>每当学会 Spring Boot 中的一个知识点，不妨想想这个功能在 Spring 框架中要如何使用，如何配置，两边都搞懂了，互相印证，加深对一个知识点的理解。</li><li>多多关注 Spring Boot 的发展动态。不同于传统的框架可能一年更新一两次，Spring Boot 更新非常频繁，二次每次更新都会带来一些好玩的东西，可能会有新的 API 加入进来，也可能会有旧的 API 失效，变化大，因此多多关注，避免掉坑。</li></ol><p>最后，我这里给大家列举几个我自己经常关注的几个资源。</p><h3 id=\"4-1-官方文档\"><a href=\"http://www.javaboy.org/2020/0224/springboot-guide.html#4-1-%E5%AE%98%E6%96%B9%E6%96%87%E6%A1%A3\" title=\"4.1 官方文档\"></a>4.1 官方文档</h3><p>老实说，Spring Boot 的官方文档是我接触的所有官方文档中最条理清晰浅显易懂的，大家做开发，多多少少都接触过一些第三方的开放平台，很多平台的文档真是让人忍不住想吐槽，框架都做出来了，认认真真写个文档有那么难么？</p><p>不过 Spring Boot 的官方文档可以算是非常非常友好了。虽然是英文的，但是实际上对英文要求并不高，连读带猜，其实很容易明白它的含义，我一般对 Spring Boot 中某个知识点有疑问的时候，都是首选官方文档，当前最新版的官方文档地址是：</p><ul><li><a href=\"https://docs.spring.io/spring-boot/docs/2.2.4.RELEASE/reference/html\" target=\"_blank\" rel=\"noopener\">https://docs.spring.io/spring-boot/docs/2.2.4.RELEASE/reference/html</a></li></ul><p>当然，如果你嫌官方文档打开慢，松哥也帮你下载好了最新版的 pdf，公众号后台回复&nbsp;<code>springboot2.2.4</code>&nbsp;可以获取。</p><h3 id=\"4-2-Spring-官方博客\"><a href=\"http://www.javaboy.org/2020/0224/springboot-guide.html#4-2-Spring-%E5%AE%98%E6%96%B9%E5%8D%9A%E5%AE%A2\" title=\"4.2 Spring 官方博客\"></a>4.2 Spring 官方博客</h3><p>每次 Spring 或者 Spring Boot 发新版本，松哥都会去看一下新版本有哪些好玩的东西，增加了哪些内容。我不可能把源码读一遍然后总结出来它的变化，那一般是如何获取权威的第一手信息呢？关注 Spring 官方博客即可。</p><p>打开 Spring 官网，在顶部菜单里有一个选项就是 Blog，关于 Spring 家族产品的任何更新计划，更新结果，都会在这里通知到大家</p>');
INSERT INTO `article` VALUES (4, 'security开发跨域问题', '2020-02-19', '陈登宝', 1, '<p><span style=\"background-color: rgb(139, 170, 74);\">最好在vue开发环境中，否则可能会出现登陆之后其他api302（估计是session在跨域中丢失）</span></p><p><span style=\"background-color: rgb(139, 170, 74);\"><br></span></p><p>在package.json同级创建vue.config.js</p><p><br></p><div><span style=\"background-color: rgb(77, 128, 191);\"><span>let</span><span> </span><span>proxyobj</span><span>={};</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>proxyobj</span><span>[</span><span>\'/\'</span><span>]={</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>  </span><span>ws:</span><span>false</span><span> ,</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>  </span><span>target:</span><span>\'http://localhost:8090\'</span><span>,</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>  </span><span>changeOrigin:</span><span>true</span><span>,</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>  </span><span>pathRewrite:</span><span>{</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>     </span><span>\'^/\'</span><span>:</span><span>\'\'</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\">  }</span></div><div><span style=\"background-color: rgb(77, 128, 191);\">}</span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span> </span><span>module</span><span>.</span><span>exports</span><span>={</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>  </span><span>devServer:</span><span>{</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>    </span><span>host:</span><span>\'localhost\'</span><span>,</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>    </span><span>port:</span><span>8080</span><span>,</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\"><span>    </span><span>proxy:proxyobj</span></span></div><div><span style=\"background-color: rgb(77, 128, 191);\">  }</span></div><div><span style=\"background-color: rgb(77, 128, 191);\"> }</span></div><p><divcourier new\',=\"\" monospace;font-weight:=\"\" normal;font-size:=\"\" 14px;line-height:=\"\" 21px;white-space:=\"\" pre;\"=\"\"><br></divcourier></p>');
INSERT INTO `article` VALUES (6, 'MacBook Pro 入手一年了，到底香不香？', '2020-04-01', 'chen', 2, '<p>最近又有小伙伴问到底值不值得入手一台 MacBook Pro，松哥自己在 2018 年 10 月份的时候入手了一台，到现在为止，也用了一年多了，今天就来和小伙伴们聊一聊使用感受，至于到底值不值，需要大家自行判断。</p><p>我的第一台笔记本是大一第二学期（2012 年 4 月份）入手的，是一台 Sony 的 VAIO，这台电脑现在也一直在用，给大家录制的视频教程都是用这台电脑录制了，在接近 8 年的时间里，这台笔记本一直是我的主力机，更重要的是从来没有拿去修过，质量很棒，因此当我想要换电脑的时候，首先考虑的还是 VAIO，可惜 Sony 在 2014 年将 PC 业务整体出售，VAIO 这个品牌也卖给了 JIP（Japan Industrial Partners Inc.），从此退出了笔记本电脑市场。</p><p>排除了 VAIO 之后，剩下的选项就是 MacBook Pro 了。其实很早就想入手一台 mbp 了，2016 年那会，刚毕业一年，薪水翻了三倍，我想入手一台 mbp 奖励自己，但后来还是控制住自己了，买了一个固态硬盘给我的 Windows 装上了，然后就把买 mbp 这个欲望压下来了。去年 10 月份的时候，我的第一本书刚刚交稿给出版社，还是蛮激动的，心想这下可以买一个 mbp 了吧，这次没能成功控制住自己，于是就买了，要买就买好的，于是我在 Apple 官网定制了一台 32G 内存的 mbp，当时还送了一个 beat solo 耳机。</p><p>耳机一直是女票在用，我就不多说了，我这次主要和大家说说作为一个程序员，我比较关注的开发工具的使用感受。</p><h2 id=\"idea-秒开\"><a href=\"http://www.javaboy.org/2020/0108/mackbookpro.html#idea-%E7%A7%92%E5%BC%80\" title=\"idea 秒开\"></a>idea 秒开</h2><p>第一次知道原来 IntelliJ IDEA 可以秒开。最早用 Windows 的时候，那会还不是固态硬盘，每天到公司后，先按下开机键，然后去打杯水，回来电脑刚好开机，然后点下 idea 图标，再去上个厕所，回来后 idea 也开好了，后来换了个固态硬盘，Windows 开机基本上可以控制在 10s 之内，所以每条到公司的流程也调整了下，先开机，然后等一会开机完成后，开 idea，然后再去打水，回来的时候 idea 就刚好开好。</p><p>用了 mbp 之后，idea 和 webstorm 这两个平时开发用的最多的软件，基本都可以秒开，相应的，idea 在项目编译运行的时候，也要快很多。这样开发效率提升可不是一丁半点。</p><h2 id=\"不用关机\"><a href=\"http://www.javaboy.org/2020/0108/mackbookpro.html#%E4%B8%8D%E7%94%A8%E5%85%B3%E6%9C%BA\" title=\"不用关机\"></a>不用关机</h2><p>mbp 还有一个非常有用的地方就是不用关机，想想你做开发，idea、webstorm、vscode、sequel pro、postman、命令行等等开了一堆，现在下班了，全部关掉回家，明天来了再挨个打开，不是很费事么？mac 用完了，直接合上盖就可以了，下次再打开盖子，这些东西都还可以接着使用。不用再一个一个打开。</p><p>我刚开始用的时候，对这个功能很不习惯，每次用完还是习惯性的关机，后来时间久了，慢慢就接受了，现在我的 mbp 估计都快一年没关过机了，依然用着很流畅。</p><h2 id=\"命令行好用\"><a href=\"http://www.javaboy.org/2020/0108/mackbookpro.html#%E5%91%BD%E4%BB%A4%E8%A1%8C%E5%A5%BD%E7%94%A8\" title=\"命令行好用\"></a>命令行好用</h2><p>mbp 里边的命令行也是非常方便，远程连接 Linux 服务器时，甚至不需要额外准备第三方工具，直接在命令行用命令连接。</p><p>但是在命令行连接远程服务器，如果 ssh 连接空闲一段时间后，就会自动断开，下次又得重新连接，我在网上看了一些方案之后，后来还是决定用一些工具得了，综合比较后，使用了 Royal TSX，既可以做远程连接，又可以方便的上传文件。</p><h2 id=\"Adobe-Pr-真快\"><a href=\"http://www.javaboy.org/2020/0108/mackbookpro.html#Adobe-Pr-%E7%9C%9F%E5%BF%AB\" title=\"Adobe Pr 真快\"></a>Adobe Pr 真快</h2><p>因为我今年一直在录视频教程，视频要二次处理剪辑啥的，二次处理我使用了 Adobe Premiere Pro ，刚开始我是在 Windows 上处理的，但是太慢了，一个 10 分钟左右的视频，渲染起来的时间接近 20 分钟，漫长的等待实在有点受不了，后来就把视频的二次处理换到 mbp 上来处理，10 分钟的视频，大概一两分钟就可以渲染好，速度非常快。</p><p>不过在 mbp 上处理视频，也有一个问题，就是视频长的时候（10 分钟以上），可以明显的听到电脑风扇呼呼响，渲染完成后，电脑又会慢慢冷静下来，这是一个非常明显的变化。这个让我有点吃惊，因为我印象中，mbp 应该比较擅长做视频处理，但是这块实际操作起来，感觉它还是有点压力。</p><p>至于为什么不在 mbp 上使用 FINAL CUT，这是因为有的时候我还需要搭配着 Windows 使用，为了能够在 Windows 和 mbp 之间平滑切换，选择了 Adobe Pr。</p><h2 id=\"Docker-必备\"><a href=\"http://www.javaboy.org/2020/0108/mackbookpro.html#Docker-%E5%BF%85%E5%A4%87\" title=\"Docker 必备\"></a>Docker 必备</h2><p>个人觉得，使用 mbp，一定安装一个 Docker，Docker 在 mbp 上安装非常方便，比 windows 省事很多，Docker 装好之后，以后的 MySQL、RabbitMQ、Redis、Nginx 等工具，都可以直接使用 Docker 来安装，方便了很多。我一直就是这样搞的。</p><p>不过 Docker 使用过程中，遇到过一次超级耗内存的情况，就是有一次突然电脑风扇呼呼响，检查之后发现是 Docker 的问题，关掉的 Docker 之后就好了，不过后来使用 Docker 没再遇到这个情况。</p><h2 id=\"Sequel-Pro\"><a href=\"http://www.javaboy.org/2020/0108/mackbookpro.html#Sequel-Pro\" title=\"Sequel Pro\"></a>Sequel Pro</h2><p>数据库连接工具我使用了 Sequel Pro，在 Windows 上，我一直是 Navicat 和 SQLyog 两个切换着使用，mbp 上也有 Navicat ，但是搞起来比较麻烦，我就懒得去弄了，于是入乡随俗，选择了 Sequel Pro。</p><p>Sequel Pro 其实用着也没啥不方便的地方，感觉我自己的平时的需求都够用了。</p><h2 id=\"mbp-Vs-Ubuntu\"><a href=\"http://www.javaboy.org/2020/0108/mackbookpro.html#mbp-Vs-Ubuntu\" title=\"mbp Vs Ubuntu\"></a>mbp Vs Ubuntu</h2><p>在公司做开发的时候，用 Ubuntu 做主力系统也用了很长一段时间，这也是我后来切换到 mbp 上之后，没有太多的陌生感的原因之一。个人感觉 mbp 和 Ubuntu 有很多相似的地方，相比于 Ubuntu ，mbp 最大的优势在于软件生态丰富，像 Adobe 全家桶，微信这些东西，在 mbp 上安装就不用折腾。</p><p>小伙伴们要是未来有入手 mbp 的打算，我建议现在可以在 Windows 笔记本上整一个双系统，装上 Ubuntu，这样有一天当你想切换到 mbp 上时，就可以平滑过渡。</p><h2 id=\"还要-Windows-系统吗\"><a href=\"http://www.javaboy.org/2020/0108/mackbookpro.html#%E8%BF%98%E8%A6%81-Windows-%E7%B3%BB%E7%BB%9F%E5%90%97\" title=\"还要 Windows 系统吗\"></a>还要 Windows 系统吗</h2><p>老实说，Windows 还是离不开。至少我这边有不少事情还是需要在 Windows 上做，例如平时给大家录制视频教程，mbp 当然也可以录，但是录出来的视频文件超级大，不利于分发和传播，所以我一直选择在 Windows 上录制。不过我不太喜欢在 mbp 上搞 Windows ，所以现在是两台笔记本，mbp 是主力，之前那台用了八年的 Windows 打辅助，两台设备切换着用。</p><p>其实在电脑上我不太喜欢折腾，一般能满足需求，我就会一直先用着。换了 mbp 之后，使用最多的软件还是那几个开发工具，其他 mbp 上的功能发掘的少，不过也在慢慢摸索。</p><p><a id=\"more\"></a></p><p>整体来说，还是比较香的。</p>');
INSERT INTO `article` VALUES (10, '标题测试', '2020-04-01', '作者测试', 10, '<p>正文测试</p>');
INSERT INTO `article` VALUES (12, 'qgtest', '2020-03-31', 'haha', 2, '<p>追加的内容</p>');
INSERT INTO `article` VALUES (13, '2', '2019-12-31', '2', 2, '2');
INSERT INTO `article` VALUES (14, 'test', '2020-04-01', 'test', 2, '');
INSERT INTO `article` VALUES (15, 'we首页', '2020-04-02', '陈登宝', 10, '');
INSERT INTO `article` VALUES (16, '123', '2020-04-02', '123', 10, '<p>123</p>');
INSERT INTO `article` VALUES (17, '首页', '2020-04-02', '陈登宝', 10, '<p>本博客管理系统拥有三个不同权限等级的账号</p><ol><li><p>权限管理员拥有所有权限&nbsp; 账号：root密码：123</p></li><li><p>普通管理员拥有除用户设置以外权限 账号：admin密码：123</p></li><li><p>普通用户只有提交文章的权限 账号：chen 密码：123</p></li></ol><p><br></p>');
COMMIT;

-- ----------------------------
-- Table structure for article_column
-- ----------------------------
DROP TABLE IF EXISTS `article_column`;
CREATE TABLE `article_column` (
  `column` varchar(255) DEFAULT NULL,
  `cid` int NOT NULL AUTO_INCREMENT,
  `updatetime` date DEFAULT NULL,
  PRIMARY KEY (`cid`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_column
-- ----------------------------
BEGIN;
INSERT INTO `article_column` VALUES ('技术分享', 1, '2020-02-09');
INSERT INTO `article_column` VALUES ('生活分享', 2, '2020-02-09');
INSERT INTO `article_column` VALUES ('栏目测试', 10, '2020-02-10');
COMMIT;

-- ----------------------------
-- Table structure for Comments
-- ----------------------------
DROP TABLE IF EXISTS `Comments`;
CREATE TABLE `Comments` (
  `pid` int NOT NULL AUTO_INCREMENT,
  `aid` int DEFAULT NULL,
  `Commenttime` date DEFAULT NULL,
  `content` varchar(255) DEFAULT NULL,
  `user` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`pid`)
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Comments
-- ----------------------------
BEGIN;
INSERT INTO `Comments` VALUES (1, 1, '2020-02-14', '666', 'test1');
INSERT INTO `Comments` VALUES (6, 1, '2020-03-23', 'test2', 'deng');
INSERT INTO `Comments` VALUES (11, 4, '2020-03-27', 'ok', 'chen');
COMMIT;

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int NOT NULL AUTO_INCREMENT,
  `pattern` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
BEGIN;
INSERT INTO `menu` VALUES (1, '/home');
INSERT INTO `menu` VALUES (2, '/article/**');
INSERT INTO `menu` VALUES (3, '/column/**');
INSERT INTO `menu` VALUES (4, '/comment/**');
INSERT INTO `menu` VALUES (5, '/submit/**');
INSERT INTO `menu` VALUES (6, '/userset/**');
INSERT INTO `menu` VALUES (7, '/userRegister/**');
COMMIT;

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `mid` int DEFAULT NULL,
  `rid` int DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=27 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
BEGIN;
INSERT INTO `menu_role` VALUES (10, 1, 3);
INSERT INTO `menu_role` VALUES (12, 5, 3);
INSERT INTO `menu_role` VALUES (13, 1, 1);
INSERT INTO `menu_role` VALUES (14, 2, 1);
INSERT INTO `menu_role` VALUES (15, 3, 1);
INSERT INTO `menu_role` VALUES (16, 4, 1);
INSERT INTO `menu_role` VALUES (17, 5, 1);
INSERT INTO `menu_role` VALUES (18, 6, 1);
INSERT INTO `menu_role` VALUES (19, 7, 1);
INSERT INTO `menu_role` VALUES (20, 1, 2);
INSERT INTO `menu_role` VALUES (21, 2, 2);
INSERT INTO `menu_role` VALUES (23, 4, 2);
INSERT INTO `menu_role` VALUES (24, 5, 2);
INSERT INTO `menu_role` VALUES (26, 3, 2);
COMMIT;

-- ----------------------------
-- Table structure for Nav
-- ----------------------------
DROP TABLE IF EXISTS `Nav`;
CREATE TABLE `Nav` (
  `nav_id` int NOT NULL AUTO_INCREMENT,
  `nav_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`nav_id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Nav
-- ----------------------------
BEGIN;
INSERT INTO `Nav` VALUES (1, '文章管理');
INSERT INTO `Nav` VALUES (2, '用户管理');
INSERT INTO `Nav` VALUES (3, '评论管理');
INSERT INTO `Nav` VALUES (4, '栏目管理');
COMMIT;

-- ----------------------------
-- Table structure for Nav_second
-- ----------------------------
DROP TABLE IF EXISTS `Nav_second`;
CREATE TABLE `Nav_second` (
  `nav_id` int NOT NULL,
  `nav_Second_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`nav_Second_name`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of Nav_second
-- ----------------------------
BEGIN;
INSERT INTO `Nav_second` VALUES (1, '提交文章', 'publishedListOf');
INSERT INTO `Nav_second` VALUES (1, '文章列表', '/articleLists');
INSERT INTO `Nav_second` VALUES (4, '栏目相关', '/column');
INSERT INTO `Nav_second` VALUES (2, '用户注册', '/userRegister');
INSERT INTO `Nav_second` VALUES (2, '用户设置', '/userset');
INSERT INTO `Nav_second` VALUES (3, '评论列表', '/comment');
COMMIT;

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `namezh` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
BEGIN;
INSERT INTO `role` VALUES (1, 'ROLE_root', '权限管理员');
INSERT INTO `role` VALUES (2, 'ROLE_admin', '普通管理员');
INSERT INTO `role` VALUES (3, 'ROLE_user', '用户');
COMMIT;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `password` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `enabled` tinyint(1) NOT NULL,
  `locked` tinyint(1) NOT NULL,
  `realname` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(32) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES (1, 'root', '123', 1, 0, '张剑锋', '123456');
INSERT INTO `user` VALUES (2, 'admin', '123', 1, 0, '张无忌', '98765');
INSERT INTO `user` VALUES (3, 'chen', '123', 1, 0, '陈登宝', '13003968261');
INSERT INTO `user` VALUES (16, 'igs', '123', 1, 0, 'haha', '13003968261');
INSERT INTO `user` VALUES (17, 'test1', '123', 1, 0, '张三丰', '13003968261');
INSERT INTO `user` VALUES (19, 'test2', '123', 1, 0, '张三丰', '13003968261');
INSERT INTO `user` VALUES (20, 'test3', '123', 1, 0, '张三丰', '13003968261');
INSERT INTO `user` VALUES (22, 'test5', '123', 1, 0, '张无忌', '13003968261');
INSERT INTO `user` VALUES (23, 'test6', '123', 1, 0, '张无忌', '13003968261');
INSERT INTO `user` VALUES (24, 'test8', '123', 1, 0, '张无忌', '13003968261');
COMMIT;

-- ----------------------------
-- Table structure for user_role
-- ----------------------------
DROP TABLE IF EXISTS `user_role`;
CREATE TABLE `user_role` (
  `id` int NOT NULL AUTO_INCREMENT,
  `uid` int NOT NULL,
  `rid` int NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user_role
-- ----------------------------
BEGIN;
INSERT INTO `user_role` VALUES (1, 1, 1);
INSERT INTO `user_role` VALUES (2, 2, 2);
INSERT INTO `user_role` VALUES (3, 3, 3);
INSERT INTO `user_role` VALUES (11, 6, 3);
INSERT INTO `user_role` VALUES (14, 16, 3);
INSERT INTO `user_role` VALUES (15, 17, 2);
INSERT INTO `user_role` VALUES (16, 19, 2);
INSERT INTO `user_role` VALUES (17, 20, 2);
INSERT INTO `user_role` VALUES (19, 22, 3);
INSERT INTO `user_role` VALUES (20, 23, 3);
INSERT INTO `user_role` VALUES (21, 24, 3);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
