<template>
  <div class="login-container">
    <div class="login-box">
      <!--  头像-->
      <div class="login-Avatar">
        <img src="../assets/welogo.png" alt=""/>
      </div>
      <!--  登录表单-->
      <el-form  ref="info" :rules="rules" :model="loginForm" label-width="80px" class="login-form">
        <el-form-item  label="用户名" prop="username">
          <el-input v-model="loginForm.username"  suffix-icon="el-icon-user"/>
        </el-form-item>
        <el-form-item prop="password" label="密码">
          <el-input v-model="loginForm.password" suffix-icon='el-icon-s-comment'   show-password/>
        </el-form-item>
<!--        按钮-->
        <el-form-item  class="login-btn">
          <el-button type="primary" v-on:click="loginBtn">登录</el-button>
          <el-button type="info" v-on:click="reset">重置</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
  export default {
    data(){
      return{
        //表单登录数据的绑定对象
        loginForm :{
          username: "chen",
          password: "123668"
        },
        rules : {
          username: [
            { required: true, message: '请输入用户名', trigger: 'blur' },
            { min: 3, max: 5, message: '长度在 3 到 5 个字符', trigger: 'blur' }
          ],
          password: [
            {required:true,message :"请输入密码",trigger:"blur"}
          ]
        }
      };
    },
    methods : {
    reset(){
console.log(this)
     // this.$refs.info.resetFields();
//test
      this.$http.post("find")
  },
      loginBtn(){
        this.$refs.info.validate(async boolean => {
          console.log(boolean)
          if (!boolean) return ;
            const axiosResponse = await this.$http.post("login", this.loginForm)
          console.log(axiosResponse)
          console.log(axiosResponse.data.msg)

         if (axiosResponse.data.msg==="成功") {
           this.$message.success("登陆成功，跳转中")
           //后续做用户验证token 或者Spring Security

           this.$router.push("/home");
           return ;
         }

          return this.$message.error("登陆失败，请检查")
        });
      }
    }
  };
</script>


<style>

  .login-container {
    background-color: #409EFF;
    height: 100%;
  }

  .login-box {
    height: 350px;
    width: 550px;
    background-color: aliceblue;
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -50%);
    border-radius: 20px;
  }

  .login-Avatar {
    width: 130px;
    height: 130px;
    position: absolute;
    left: 50%;
    border: 1px solid #eeeeee;
    border-radius: 50%;
    transform: translate(-50%, -50%);
    background-color: #45BC80;

  }

  img {
    width: 100%;
    height: 100%;
    border-radius: 50%;
    border-color: #409EFF;
  }
.login-form{
  position: absolute;
  bottom: 50px ;
  width: 100%;

  padding-right: 40px;
  box-sizing: border-box;
}
  .login-btn{
    position: center;
  }

</style>
