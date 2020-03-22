<template>
  <div>
    <!--      面包屑-->
    <el-breadcrumb separator="/">
      <el-breadcrumb-item :to="{ path: '/home' }">首页</el-breadcrumb-item>
      <el-breadcrumb-item>用户管理</el-breadcrumb-item>
      <el-breadcrumb-item>用户注册</el-breadcrumb-item>
    </el-breadcrumb>
    <!--卡片-->
    <el-card class="body-card box-card">

      <el-form :model="ruleForm" status-icon :rules="rules" ref="ruleForm" label-width="100px" class="demo-ruleForm">
        <el-form-item label="用户名" prop="username">
          <el-input  class="inputs" type="text" v-model="ruleForm.username" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="密码" prop="password">
          <el-input  class="inputs" type="password" v-model="ruleForm.password" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="确认密码" prop="checkPass">
          <el-input class="inputs" type="password" v-model="ruleForm.checkPass" autocomplete="off"></el-input>
        </el-form-item>
        <el-form-item label="真实姓名" prop="realname">
          <el-input class="inputs" v-model="ruleForm.realname"></el-input>
        </el-form-item>
        <el-form-item label="手机号码" prop="phone">
          <el-input  class="inputs" v-model="ruleForm.phone"></el-input>
        </el-form-item>
        <el-form-item label="特殊资源">
          <el-radio-group v-model="ruleForm.Authority" size="medium">
            <el-radio border :label="item.id" v-for="(item,index) in Authoritys" :key="index">{{item.namezh}}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm('ruleForm')">提交</el-button>
          <el-button @click="resetForm('ruleForm')">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
  export default {
    data() {
      // const checkAge = (rule, value, callback) => {
      //   if (!value) {
      //     return callback(new Error('年龄不能为空'));
      //   }
      //   setTimeout(() => {
      //     if (!Number.isInteger(value)) {
      //       callback(new Error('请输入数字值'));
      //     } else {
      //       if (value < 18) {
      //         callback(new Error('必须年满18岁'));
      //       } else {
      //         callback();
      //       }
      //     }
      //   }, 1000);
      // };
      const validatePass = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请输入密码'))
        } else {
          if (this.ruleForm.checkPass !== '') {
            this.$refs.ruleForm.validateField('checkPass')
          }
          callback()
        }
      }
      const validatePass2 = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请再次输入密码'))
        } else if (value !== this.ruleForm.password) {
          callback(new Error('两次输入密码不一致!'))
        } else {
          callback()
        }
      }
      const checkPhone=(rule, value, callback) => {
        if (value=== ''){
          callback(new Error('请输入手机'))
        }else if ( !(/^1[3456789]\d{9}$/.test(value))){
          callback(new Error('手机号码有误，请重填'))
        }
        else {
          callback()
        }

      }
      return {
        Authoritys: [],
        ruleForm: {
          username: '',
          password: '',
          checkPass: '',
          realname: '',
          phone: '',
          Authority: ''
        },
        rules: {
          username: [
            { required:true,message:'请输入用户名',trigger: 'blur'},
            { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
          ],
          password: [
            { required:true,message:'请输入密码',trigger: 'blur'},
          ],
          checkPass: [
            { validator: validatePass2, trigger: 'blur' }
          ],
          realname: [
            { required:true,message:'请输入姓名',trigger: 'blur'},
            { min: 2, max: 8, message: '长度在 2 到 8 个字符', trigger: 'blur' }
          ],
          phone: [
            { required:true,message:'请输入手机号码',trigger: 'blur'},
            { validator: checkPhone, trigger: 'blur' }
          ]

        }
      };
    },
    created () {
      this.getAuthoritys()
    },
    methods: {
      // 获取权限名字
      async getAuthoritys(){
        try {
          const {data:res} = await this.$http.get("/userRegister/getAuthoritys")
          if("403"===res.code){
          this.$message.error(res.msg)
            await this.$router.push("/noauthority")
            return ;
          }
          else if(res){
            this.Authoritys=res;
            console.log(res)
          }
        }catch (e) {

        }
      },
      submitForm(formName) {
        console.log( this.$refs[formName].validate)
        this.$refs[formName].validate(async boolean=>{
         console.log(boolean)
         if (!boolean){
           return ;
         }
         try {
           const params = new URLSearchParams();
           params.append("username", this.ruleForm.username);
           params.append("password", this.ruleForm.password);
           params.append("realname", this.ruleForm.realname);
           params.append("phone", this.ruleForm.phone);
           params.append("Authority", this.ruleForm.Authority);
           const {data :res} = await this.$http.post("/userRegister/register", params);
           if ("注册成功"===res.msg){
             this.$message.success("注册成功")
             this.$refs['ruleForm'].resetFields();
             return
           }else {
             this.$message.error(res.msg)
             this.$refs['ruleForm'].resetFields();
             return
           }
         }catch (e) {
           this.$message.error("服务器错误")
         }
       })
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      }
    },

  }

</script>

<style scoped>
  .inputs{
  width: 300px;
}
</style>
