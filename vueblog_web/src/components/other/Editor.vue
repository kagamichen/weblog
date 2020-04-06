<template>
  <div id="editor"></div>
</template>

<script>
  import E from 'wangeditor'
  export default {
    data() {
      return {
        editor: ""
      }
    },
    methods: {
      init() {
        const _this = this;
        this.editor = new E('#editor');

        this.setMenus();//设置菜单
        this.editor.customConfig.zIndex = 100
        this.editor.create();//创建编辑器
        this.editor.change = function() { // 这里是change 不是官方文档中的 onchange
          // console.log(this.txt.html());// 编辑区域内容变化时，实时打印出当前内容
          _this.$emit('changeHtml', this.txt.html());
        }
      },
      setMenus() {
        this.editor.customConfig.menus = [
          'head',  // 标题
          'bold',  // 粗体
          'fontSize',  // 字号
          'fontName',  // 字体
          'italic',  // 斜体
          'underline',  // 下划线
          'strikeThrough',  // 删除线
          'foreColor',  // 文字颜色
          'backColor',  // 背景颜色
          'link',  // 插入链接
          'list',  // 列表
          'justify',  // 对齐方式
          'image',  // 插入图片
          'table',  // 表格
          'undo',  // 撤销
          'redo'  // 重复
        ]
      },
      getHtml() {
        return this.editor.txt.html();
      },
      setHtml(txt) {
        this.editor.txt.html(txt);
      }
    },
    mounted() {
        this.init();
    }
  }
</script>
