<template>
  <div class="home">
    <h1 class="title">vue todo</h1>
    <hr>
    <div id="main_form" class="card">
        <form v-on:submit.prevent="addTask">
        <div id="inside_stuff">
        <h2 class="subtitle">Add task</h2>
           <div class="field">
              <label class="label">description</label>
              <div class="control">
                <input id="desc_input" class="input" type="text" v-model="description">
              </div>
           </div>

           <div class="field">
             <label class="label">status</label>
             <div class="control">
                <div class="select">
                   <select v-model="status">
                    <option value="1">to do</option>
                    <option value="2">done</option>
                   </select>
                </div>
             </div>
           </div>

           <div class="field">
             <div class="control">
               <button class="btn btn-success">submit</button>
             </div>
           </div>
           </div>
        </form>
      </div>

      <div class="columns">
        <div class="column is-6">
          <h2 class="subtitle">to do</h2>
          <div class="todo">
            <div class="card" v-for="task in tasks" v-if="task.status === 1" v-bind:key="task.id">
                <div class="card-content">
                    <div class="left_content">
                        {{ task.description }}
                    </div>
                    <button class="right_btn btn btn-danger" @click="deleteTask(task.id)">delete</button>
                    <button class="right_btn btn btn-outline-warning" @click="setStatus(task.id, 2)">done</button>
                </div>
            </div>
          </div>
        </div>
        <div class="column is-6">
            <h2 class="subtitle">done</h2>
            <div class="done">
                <div class="card" v-for="task in tasks" v-if="task.status === 2" v-bind:key="task.id">
                    <div class="card-content">
                        <div class="left_content">
                            {{ task.description }}
                        </div>
                        <button class="right_btn btn btn-danger" @click="deleteTask(task.id)">delete</button>
                        <button class="right_btn btn btn-outline-warning" @click="setStatus(task.id, 1)">to do</button>
                    </div>
                </div>
            </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>

import axios from 'axios'

export default {
  name: 'Home',
  data () {
    return {
        tasks: [],
        description: '',
        status: 'todo'
    }
  },
  mounted () {
    this.getTasks()
  },
  methods: {
    getTasks () {
       axios({
          method: 'get',
          url: 'http://127.0.0.1:8000/source/tasks/'
        }).then(response => this.tasks = response.data)
    },
    async addTask() {
      if (this.description) {
        await axios({
          method: 'post',
          url: 'http://127.0.0.1:8000/source/tasks/',
          data: {
            description: this.description,
            status: this.status
          },
        }).then((response) => {
          let newTask = {
            'id': response.data.id,
            'description': this.description,
            'status': this.status
          }
          this.tasks.push(newTask)
          this.getTasks()
          this.description = ''
          this.status = 2
        }).catch((error) => {
          console.log(error)
        })
      }
    },
    setStatus(task_id, status) {
      const task = this.tasks.filter(task => task.id === task_id)[0]
      const description = task.description
      axios({
        method: 'put',
        url: 'http://127.0.0.1:8000/source/tasks/' + task_id + '/',
        headers: {
          'Content-Type': 'application/json',
        },
        data: {
          status: status,
          description: description
        },
      }).then(() => {
        task.status = status
      })
    },
    deleteTask(task_id) {
      const task = this.tasks.filter(task => task.id === task_id)[0]
      axios({
        method: 'delete',
        url: 'http://127.0.0.1:8000/source/tasks/' + task_id + '/',
        headers: {
          'Content-Type': 'application/json',
        },
      }).then(() => {
        this.getTasks()
      })
    }
  }
}

</script>
<style lang="scss">
.select, select {
  width: 40%;
}

.card {
  margin-bottom: 20px;
}

.done {
  opacity: 0.3;
}

.right_btn {
    float: right;
    margin-right: 6px;
}

.card_content {
    text-align: center;
}

.left_content {
 float: left;
}

.columns {
    margin-left: 0.25rem;
    margin-right: 0.25rem;
}

#main_form {
    width: 50%;
    margin:auto;
    margin-bottom: 60px;
}

#desc_input {
    width: 75%;
}

#inside_stuff {
    margin-bottom: 20px;
    margin-top: 18px;
}
</style>