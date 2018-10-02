function integrateGitment(router) {
  const linkGitment = document.createElement('link')
  linkGitment.href = 'https://unpkg.com/gitalk/dist/gitalk.css'
  linkGitment.rel = 'stylesheet'
  const scriptGitalk = document.createElement('script')
  document.body.appendChild(linkGitment)
  scriptGitalk.src = 'https://unpkg.com/gitalk/dist/gitalk.min.js'
  document.body.appendChild(scriptGitalk)

  router.afterEach((to) => {
    if (scriptGitalk.onload) {
      renderGitalk(to.fullPath)
    } else {
      scriptGitalk.onload = () => {
        const commentsContainer = document.createElement('div')
        commentsContainer.id = 'comments-container'
        commentsContainer.classList.add('content')
        const $page = document.querySelector('.page')
        if ($page) {
          $page.appendChild(commentsContainer)
          renderGitalk(to.fullPath)
        }
      }
    }
  })

  function renderGitalk(fullPath) {
    const gitalk = new Gitalk({
      clientID: '6ac606b7bad30bff534c',
      clientSecret: 'cf218bccc6b17b1feaee02b406d0c1f021aaa5e7',
      repo: 'https://github.com/iofu728/blog',
      owner: 'iofu728',
      admin: ['iofu728'],
      language: ['zh-CN', 'en'],
      id: fullPath,
      distractionFreeMode: false  // Facebook-like distraction free mode
    })

    gitalk.render('comments-container')
  }
}

export default ({
  Vue,      // VuePress 正在使用的 Vue 构造函数
  options,  // 附加到根实例的一些选项
  router,   // 当前应用的路由实例
  siteData  // 站点元数据
}) => {
  try {
    // 生成静态页时在node中执行，没有document对象
    integrateGitment(router)
  } catch (e) {
    console.error(e.message)
  }
}
