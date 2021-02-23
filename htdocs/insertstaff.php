<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans&display=swap" rel="stylesheet">
    <title>SEJEM</title>
    <style>
        body {
            font-family: Arial, Helvetica, sans-serif;
        }
        h4{
            font-family: 'Open Sans', sans-serif;
            color:red;
            font-size: 18pt;
        }

        input[type=text],
        input[type=password] {
            width: 100%;
            padding: 12px 20px;
            margin: 8px 0;
            display: inline-block;
            border: 1px solid #ccc;
            box-sizing: border-box;
        }

        button {
            background-color:#333;
            color: rgb(255, 255, 255);
            padding: 14px 20px;
            margin: 8px 0;
            border: none;
            cursor: pointer;
            width: 100%;
        }

        button:hover {
            background-color: red;
        }

        .container {
            padding: 16px;
        }

        .modal {
            display: none;
            position: fixed;
            z-index: 1;
            left: 0;
            top: 0;
            width: 100%;
            height: 100%;
            overflow: auto;
            background-color: rgb(0, 0, 0);
            background-color: rgba(0, 0, 0, 0.4);
            padding-top: 60px;
        }

        .modal-content {
            background-color: #fefefe;
            margin: 5% auto 15% auto;
            border: 1px solid #888;
            width: 80%;
        }

        .animate {
            -webkit-animation: animatezoom 0.6s;
            animation: animatezoom 0.6s
        }

        @-webkit-keyframes animatezoom {
            from {
                -webkit-transform: scale(0)
            }

            to {
                -webkit-transform: scale(1)
            }
        }

        @keyframes animatezoom {
            from {
                transform: scale(0)
            }

            to {
                transform: scale(1)
            }
        }
    </style>
</head>

<?php
    if (isset($_GET['msg'])){
    echo '<h4 align="center"> Napacno uporabnisko ime ali geslo </h4>'; 
    }
?> 

<body>
    <form class="modal-content animate" action="Istaff.php" method="post">
        <div class="container">
            <label for="uname"><b>Username</b></label>
            <input type="text" placeholder="Vnesi username" name="uname" required>

            <label for="name"><b>Ime</b></label>
            <input type="text" placeholder="Vnesi ime" name="name" required>

            <label for="sname"><b>Priimek</b></label>
            <input type="text" placeholder="Vnesi priimek" name="sname" required>

            <label for="psw"><b>Password</b></label>
            <input type="password" placeholder="Vnesi geslo" name="psw" required>

            <button type="submit">Create User</button>
        </div>
    </form>
    </div>

    <script>
        let modal = document.getElementById('id01');
        window.onclick = function (event) {
            if (event.target == modal) {
                modal.style.display = "none";
            }
        }
    </script>
</body>

</html>