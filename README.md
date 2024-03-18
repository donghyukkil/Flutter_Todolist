# 목차

- [프로젝트 소개](#프로젝트-소개)
- [기술스택](#기술스택)
- [연락처](#연락처)

<br>

#  프로젝트 소개

```

📦lib
 ┣ 📂core
 ┃ ┣ 📂bindings
 ┃ ┃ ┗ 📜home_binding.dart
 ┃ ┗ 📂viewmodels
 ┃ ┃ ┗ 📜task_viewmodel.dart
 ┣ 📂data
 ┃ ┗ 📂models
 ┃ ┃ ┣ 📜task.dart
 ┃ ┃ ┗ 📜task.g.dart
 ┣ 📂test
 ┣ 📂ui
 ┃ ┗ 📂pages
 ┃ ┃ ┗ 📜home_page.dart
 ┣ 📂utils
 ┃ ┗ 📜dialog_utils.dart
 ┗ 📜main.dart
```

<br>
<br>

- HomePage (View):
  - 할 일 목록을 표시하고 사용자 입력을 받아 새로운 작업을 추가하거나 기존 작업을 편집하고 삭제하는 등의 기능을 수행합니다.
  - GetX의 GetMaterialApp 위젯을 사용하여 앱을 초기화하고, GetX의 Obx 위젯을 사용하여 상태 변화를 감지하고 화면을 다시 그립니다.

- TaskViewModel (View Model):
  - 비즈니스 로직을 처리하고 애플리케이션의 상태를 관리합니다.
  - GetX의 GetxController를 상속하여 상태 관리 및 의존성 주입을 담당합니다
  - Hive 데이터베이스와 상호 작용하여 할 일 목록을 로드하고 저장합니다.
  - 사용자 입력 및 상태 변경에 따라 작업을 추가, 편집, 삭제하고 작업의 상태를 토글 및 드래그앤 드롭을 구현합니다.

- Task (Model):
  - 데이터를 나타내는 모델 클래스입니다.
  - HiveObject를 상속하여 Hive 데이터베이스와 상호 작용할 수 있습니다.

- DialogUtils:
  - 다양한 상황에서 사용되는 대화 상자를 표시하기 위한 메서드를 제공합니다.
  - 예를 들어, 작업을 편집하거나 삭제하기 전에 사용자에게 확인 대화 상자를 표시하는 등의 기능을 담당합니다.

  <br>
  <br>

**CRUD, 유효성 검사, 확인 Dialog**

  <p align="center">
    <img src="https://github.com/donghyukkil/Flutter_Todolist/assets/124029691/b261ad72-c33c-4f59-b3b0-5cab6db7aea4",width="600" height="500">
  </p>

<br>

**Tap으로 진행 중/완료 한 일 구분하기**

  <p align="center">
    <img src="https://github.com/donghyukkil/Flutter_Todolist/assets/124029691/efef799e-4f31-4984-917c-a778a9e43b00",width="600" height="500">
  </p>

<br>


  **드래그앤 드롭으로 순서 변경하기**

  <p align="center">
    <img src="https://github.com/donghyukkil/Flutter_Todolist/assets/124029691/b94c0f40-3356-43a4-8ca5-5efc747c9b32",width="600" height="500">
  </p>


<br>

  **앱 재 실행 시 데이터 불러오기**

  <p align="center">
    <img src="https://github.com/donghyukkil/Flutter_Todolist/assets/124029691/749a2b9d-3e5d-4abd-a0ee-34f6cd29c2ba",width="600" height="500">
  </p>

# 기술스택

- Front-end:
  - Dart, Flutter.

- 상태 관리:
  - GetX.

- Database:
  - Hive.


<br>

# 연락처

<table>
  <tr>
    <td align="center">
      <a href="https://github.com/donghyukkil">
        <img src="https://avatars.githubusercontent.com/u/124029691?v=4" alt="길동혁 프로필" width="100px" height="100px" />
      </a>
    </td>
  </tr>
  <tr>
    <td>
      <ul>
        <li><a href="https://github.com/donghyukkil">길동혁</a></li>
		    <li>asterism90@gmail.com</li>
	    </ul>
    </td>
  </tr>
</table>
