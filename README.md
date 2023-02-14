# Bash Shell Script Database Management System (DBMS)
The Project aim to develop DBMS, that will enable users to store and retrieve the data from Hard disk.

<br>

---

## Overview


The project is a CLI Menu based app, that will provide to user this 2 Menus to make operations in database or tables

<br>

---

## How to run the project
- after cloning or downloading the project just run the main manu script `./main-manu.sh`

<br>

---

## Main Menu
- Create Database
- List Databases
- Drop Database
- Connect To Databases

<br>

<p align="center">
  <img  src="imgs/db-menu.png">
</p>

<br>

---

## Tables operations menu
Upon user Connect to Specific Database, there will be new Screen with this Menu:
- List Tables
- Create Table 
- Drop Table
- Select From Table
- Insert into Table
- Update Table
- Delete From Table
- Back to Main Menu
- Exit

<br> 

<p align="center">
  <img  src="imgs/tables-menu.png">
</p>

<br>

---

## Project Structure

The project contain 2 main directories
- **Databases** : store all database as a directory
    - Each Database (directory) store tables as a files
    - The table have 2 files
        - file for _data_ which is colon sperated file
        <p align="center">
            <img  src="imgs/table-data.png">
            <br> <i>table data</i>
        </p>

        - file for _meta-data_ about the table 
        <p align="center">
            <img  src="imgs/table-meta-data.png">
            <br> <i>table meta-data</i>
        </p>

- **scripts** : contain all scripts that used in the project divided to 2 directories
    - _**db**_ : contain all scripts related to database 
        - Create 
        - Drop 
        - List 
        - Connect
    - _**tables**_ : contain all scripts related to tables
        - Create
        - List
        - Drop
        - Select
        - Insert
        - Update
        - Delete
    - _**custom-menu**_ script
        - script that accept a title and an array then display the array elements in well formatted table

<br>

---

### Team Members:

- **Khaled Gad**
    - [Github](https://github.com/KhalidGad)
    - [LinkedIn](https://www.linkedin.com/in/khalildgad/)
- **Ahmed Nabil**
    - [Github](https://github.com/AhmedNabilSharawy)
    - [LinkedIn](https://www.linkedin.com/in/ahmed-nabil-sharawy-149880104/)
<br>

_**ITI**_

_**intake 43**_

_**Cloud Platform Development**_
