window.toggleUserList = function() {
  let userPullList = document.getElementById('navbar_user_pull_list');
  if(userPullList.dataset.open == 'true') {
    userPullList.style.display = 'none';
    userPullList.dataset.open = 'false';
  } else {
    userPullList.style.display = 'block';
    userPullList.dataset.open = 'true';
  }
};

document.addEventListener('click', (e) => {
  if(!e.target.closest('.navbar__user-pull-list') && !e.target.closest('.navbar__icon-image')) {
    let userPullList = document.getElementById('navbar_user_pull_list');
    if(userPullList.dataset.open == 'true') {
      window.toggleUserList();
    }
  }
});
