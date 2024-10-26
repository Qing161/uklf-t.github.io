<script setup>  
import { ref } from 'vue'  

const value = ref('')  
const list = ref([
  { value: '起床', isCompleted: false },  
  { value: '吃饭', isCompleted: false },  
  { value: '学习', isCompleted: false },
  { value: '工作', isCompleted: false },
  { value: '睡觉', isCompleted: false },
])  

function add() {  
  if (value.value.trim() === '') return; // Prevent adding empty todos  
  list.value.push({  
    value: value.value,  
    isCompleted: false,  
  })  
  value.value = ''  
}  

function del(index) {  
  list.value.splice(index, 1)  
}  

function toggleCompletion(index) {  
  list.value[index].isCompleted = !list.value[index].isCompleted;  
}  
</script>  

<template>  
  <div class="todo-app">  
    <div class="title">Todo App</div>  

    <div class="todo-form">  
      <input  
        v-model="value"  
        type="text"  
        class="todo-input"  
        placeholder="Add a todo"  
      />  
      <div @click="add" class="todo-button">Add Todo</div>  
    </div>  

    <div v-for="item in list" :key="item.id" :class="[item.isCompleted ? 'completed' : 'item']">
      <div>  
        <input   
          type="checkbox"   
          :checked="item.isCompleted"   
          @change="toggleCompletion(index)"   
        />  
        <span class="name">{{ item.value }}</span>  
      </div>  

      <div @click="del(index)" class="del">del</div>  
    </div>  
  </div>  
</template>  

<style scoped>

.todo-app {
  max-width: 500px;
  margin: 50px auto;
  padding: 20px;
  background-color: #f8f9fa;
  border-radius: 5px;
  box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
}

.title {
  text-align: center;
  font-size: 24px;
  color: #343a40;
  margin-bottom: 20px;
}

.todo-form {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.todo-input {
  flex-grow: 1;
  padding: 10px;
  font-size: 16px;
  border: 1px solid #ced4da;
  border-radius: 5px;
  outline: none;
}

.todo-button {
  margin-left: 10px;
  padding: 10px 20px;
  font-size: 16px;
  color: #fff;
  background-color: #007bff;
  border: none;
  border-radius: 5px;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.todo-button:hover {
  background-color: #0056b3;
}

.item,
.completed {
  display: flex;
  align-items: center;
  justify-content: space-between;
  padding: 10px;
  margin-bottom: 5px;
  border: 1px solid #dee2e6;
  border-radius: 5px;
}

.completed {
  opacity: 0.5;
  text-decoration: line-through;
}

.name {
  margin-left: 10px;
  font-size: 16px;
  color: #343a40;
}

.del {
  color: #dc3545;
  cursor: pointer;
}
</style>