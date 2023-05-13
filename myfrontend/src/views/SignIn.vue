<template>
    <!-- left side -->
    <div>
      <div class="square">
          <figure class="image is-128x128 mr-auto ml-auto mt-5" id="chefHat">
              <img src="/img/chef_hat.png">
          </figure>
          <form action="" class="form">
              <label class="label has-text-centered is-size-1 sign-label">Sign In</label>
              <div class="container">
                  <div class="field">
                      <div class="control has-icons-left">
                          <input v-model="username"
                          class="input is-success input-info is-large" type="text" placeholder="E-mail/User Name">
                          <span class="icon is-small is-left">
                              <i class="fas fa-envelope-open-text"></i>
                          </span>
                      </div>
                  </div>
                  
                  <div class="field">
                      <div class="control has-icons-left">
                          <input v-model="password"
                          class="input is-success input-info is-large" type="text" placeholder="Password">
                          <span class="icon is-small is-left">
                              <i class="fas fa-shield-alt"></i>
                          </span>
                      </div>

                  </div>

                  <button class="button is-large" type="submit" id="signInButton" @click="submit()"><a class="has-text-white">Sign In</a></button>
                  <label for="" class="label has-text-centered has-text-weight-normal is-size-6" id="label">Need an Account ? <u><a href="/user/signup">Sign up</a></u></label>
              </div>
          </form>
      </div>
      <!-- right side -->
      <figure class="image is-128x128" id="tomyamImg">
          <img src="/img/tomyamkung.png">
      </figure>
      <div class="title" id="welcome">
          Welcome To <br> Tamra Cookbook
      </div>
      <div class="subtitle" id="describe">
          Instead of going out to dinner, buy good food. <br>Cooking at home shows such affection. In a bad economy,<br> it's more important to make yourself feel good.
      </div>
    </div>
</template>
<script defer src="https://use.fontawesome.com/releases/v5.14.0/js/all.js"></script>


<script>
  import axios from '@/plugins/axios'
  // import axios from 'axios'
  export default {
    data () {
      return {
        username: '',
        password: '',
        error: '',
      }
    },
    // -------add method-----------------------------------------------------------
    methods: {
      submit () {
        const data = {
          username: this.username,
          password: this.password
        }
        axios.post('http://localhost:3000/user/signin/', data)
        .then(res => {
          const token = res.data.token                                
          localStorage.setItem('token', token)
          this.$emit('auth-change')
          this.$router.push({path: '/'})
        })
        .catch(error => {
          this.error = error.response.data
          console.log(error.response.data)
        })
      }
    }
  }
</script>

<style scope>
@import url('https://fonts.googleapis.com/css2?family=Lobster+Two:ital@1&family=Montserrat+Alternates&display=swap');
html, body{
    --yellow: #F0BB62;
    --cream: #f4eea9;
    --darkgreen: #064635;
    --lightgreen: #519259;
    --black: #000;
    --white: #fff;
    background-color: var(--darkgreen);
    overflow: hidden;
    font-family: 'Montserrat Alternates', sans-serif;
}
/* left side --------------------------------------*/
.square{
    width: 40vw;
    height: 95vh;
    background-color: var(--lightgreen);
    position: absolute;
    bottom: 0;
    left: 35px;
}
.sign-label{
    margin-top: 12%;
}
.form{
    background-color: var(--cream);
    width: 30vw;
    height: 80vh;
    padding: 50px;
    position: absolute;
    bottom: 0;
    left: 50%;
    top: 50%;
    transform: translate(-50%, -50%);
    border-radius: 30px;
}
.field{
    margin-top: 30px;
}
#signInButton{
    background-color: var(--darkgreen);
    color: var(--white);
    width: 100%;
    margin-top: 50px;
    /* margin-bottom: 10px; */
}
#signInButton:hover{
    background-color: var(--yellow);
    color: var(--darkgreen);
}
.input-info{
    width: 25vw;
}
/* contain label & input box */
.container{
    position: absolute;
    top: 50%;
    left: 50%;
    transform: translate(-50%, -45%);
    margin-top: 13%;
}
#label{
    margin-bottom: 15%;
}

/* right side ---------------------------------------*/
#tomyamImg{
   width: 75%;
   position: absolute;
   right: -25%;
   top: -55%;
}
#welcome{
    color: var(--white);
    position: absolute;
    top: 45%;
    left: 48%;
    font-size: 5vw;
}
#describe{
    color: var(--white);
    position: absolute;
    top: 75%;
    left: 48%;
    font-size: 1.5vw;
}
#chefHat{
    width: 8vw;
    position: absolute;
    left: 50%;
    transform: translateX(-50%);
    z-index: 4;
}
</style>