
_sh:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  return 0;
}

int
main(void)
{
       0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
       4:	83 e4 f0             	and    $0xfffffff0,%esp
       7:	ff 71 fc             	pushl  -0x4(%ecx)
       a:	55                   	push   %ebp
       b:	89 e5                	mov    %esp,%ebp
       d:	51                   	push   %ecx
       e:	83 ec 04             	sub    $0x4,%esp
  static char buf[100];
  int fd;

  // Ensure that three file descriptors are open.
  while((fd = open("console", O_RDWR)) >= 0){
      11:	eb 0a                	jmp    1d <main+0x1d>
      13:	90                   	nop
      14:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    if(fd >= 3){
      18:	83 f8 02             	cmp    $0x2,%eax
      1b:	7f 76                	jg     93 <main+0x93>
  while((fd = open("console", O_RDWR)) >= 0){
      1d:	83 ec 08             	sub    $0x8,%esp
      20:	6a 02                	push   $0x2
      22:	68 59 16 00 00       	push   $0x1659
      27:	e8 da 10 00 00       	call   1106 <open>
      2c:	83 c4 10             	add    $0x10,%esp
      2f:	85 c0                	test   %eax,%eax
      31:	79 e5                	jns    18 <main+0x18>
      33:	eb 1f                	jmp    54 <main+0x54>
      35:	8d 76 00             	lea    0x0(%esi),%esi
    }
  }

  // Read and run input commands.
  while(getcmd(buf, sizeof(buf)) >= 0){
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      38:	80 3d 82 1d 00 00 20 	cmpb   $0x20,0x1d82
      3f:	74 7a                	je     bb <main+0xbb>
int
fork1(void)
{
  int pid;

  pid = fork();
      41:	e8 78 10 00 00       	call   10be <fork>
  if(pid == -1)
      46:	83 f8 ff             	cmp    $0xffffffff,%eax
      49:	74 3b                	je     86 <main+0x86>
    if(fork1() == 0)
      4b:	85 c0                	test   %eax,%eax
      4d:	74 57                	je     a6 <main+0xa6>
    wait();
      4f:	e8 7a 10 00 00       	call   10ce <wait>
  while(getcmd(buf, sizeof(buf)) >= 0){
      54:	83 ec 08             	sub    $0x8,%esp
      57:	6a 64                	push   $0x64
      59:	68 80 1d 00 00       	push   $0x1d80
      5e:	e8 9d 00 00 00       	call   100 <getcmd>
      63:	83 c4 10             	add    $0x10,%esp
      66:	85 c0                	test   %eax,%eax
      68:	78 37                	js     a1 <main+0xa1>
    if(buf[0] == 'c' && buf[1] == 'd' && buf[2] == ' '){
      6a:	80 3d 80 1d 00 00 63 	cmpb   $0x63,0x1d80
      71:	75 ce                	jne    41 <main+0x41>
      73:	80 3d 81 1d 00 00 64 	cmpb   $0x64,0x1d81
      7a:	74 bc                	je     38 <main+0x38>
  pid = fork();
      7c:	e8 3d 10 00 00       	call   10be <fork>
  if(pid == -1)
      81:	83 f8 ff             	cmp    $0xffffffff,%eax
      84:	75 c5                	jne    4b <main+0x4b>
    panic("fork");
      86:	83 ec 0c             	sub    $0xc,%esp
      89:	68 e2 15 00 00       	push   $0x15e2
      8e:	e8 bd 00 00 00       	call   150 <panic>
      close(fd);
      93:	83 ec 0c             	sub    $0xc,%esp
      96:	50                   	push   %eax
      97:	e8 52 10 00 00       	call   10ee <close>
      break;
      9c:	83 c4 10             	add    $0x10,%esp
      9f:	eb b3                	jmp    54 <main+0x54>
  exit();
      a1:	e8 20 10 00 00       	call   10c6 <exit>
      runcmd(parsecmd(buf));
      a6:	83 ec 0c             	sub    $0xc,%esp
      a9:	68 80 1d 00 00       	push   $0x1d80
      ae:	e8 9d 09 00 00       	call   a50 <parsecmd>
      b3:	89 04 24             	mov    %eax,(%esp)
      b6:	e8 b5 00 00 00       	call   170 <runcmd>
      buf[strlen(buf)-1] = 0;  // chop \n
      bb:	83 ec 0c             	sub    $0xc,%esp
      be:	68 80 1d 00 00       	push   $0x1d80
      c3:	e8 78 0a 00 00       	call   b40 <strlen>
      if(chdir(buf+3) < 0)
      c8:	c7 04 24 83 1d 00 00 	movl   $0x1d83,(%esp)
      buf[strlen(buf)-1] = 0;  // chop \n
      cf:	c6 80 7f 1d 00 00 00 	movb   $0x0,0x1d7f(%eax)
      if(chdir(buf+3) < 0)
      d6:	e8 5b 10 00 00       	call   1136 <chdir>
      db:	83 c4 10             	add    $0x10,%esp
      de:	85 c0                	test   %eax,%eax
      e0:	0f 89 6e ff ff ff    	jns    54 <main+0x54>
        printf(2, "cannot cd %s\n", buf+3);
      e6:	50                   	push   %eax
      e7:	68 83 1d 00 00       	push   $0x1d83
      ec:	68 61 16 00 00       	push   $0x1661
      f1:	6a 02                	push   $0x2
      f3:	e8 68 11 00 00       	call   1260 <printf>
      f8:	83 c4 10             	add    $0x10,%esp
      fb:	e9 54 ff ff ff       	jmp    54 <main+0x54>

00000100 <getcmd>:
{
     100:	55                   	push   %ebp
     101:	89 e5                	mov    %esp,%ebp
     103:	56                   	push   %esi
     104:	53                   	push   %ebx
     105:	8b 75 0c             	mov    0xc(%ebp),%esi
     108:	8b 5d 08             	mov    0x8(%ebp),%ebx
  printf(2, "$ ");
     10b:	83 ec 08             	sub    $0x8,%esp
     10e:	68 b8 15 00 00       	push   $0x15b8
     113:	6a 02                	push   $0x2
     115:	e8 46 11 00 00       	call   1260 <printf>
  memset(buf, 0, nbuf);
     11a:	83 c4 0c             	add    $0xc,%esp
     11d:	56                   	push   %esi
     11e:	6a 00                	push   $0x0
     120:	53                   	push   %ebx
     121:	e8 4a 0a 00 00       	call   b70 <memset>
  gets(buf, nbuf);
     126:	58                   	pop    %eax
     127:	5a                   	pop    %edx
     128:	56                   	push   %esi
     129:	53                   	push   %ebx
     12a:	e8 a1 0a 00 00       	call   bd0 <gets>
  if(buf[0] == 0) // EOF
     12f:	83 c4 10             	add    $0x10,%esp
     132:	31 c0                	xor    %eax,%eax
     134:	80 3b 00             	cmpb   $0x0,(%ebx)
     137:	0f 94 c0             	sete   %al
}
     13a:	8d 65 f8             	lea    -0x8(%ebp),%esp
  if(buf[0] == 0) // EOF
     13d:	f7 d8                	neg    %eax
}
     13f:	5b                   	pop    %ebx
     140:	5e                   	pop    %esi
     141:	5d                   	pop    %ebp
     142:	c3                   	ret    
     143:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     149:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000150 <panic>:
{
     150:	55                   	push   %ebp
     151:	89 e5                	mov    %esp,%ebp
     153:	83 ec 0c             	sub    $0xc,%esp
  printf(2, "%s\n", s);
     156:	ff 75 08             	pushl  0x8(%ebp)
     159:	68 55 16 00 00       	push   $0x1655
     15e:	6a 02                	push   $0x2
     160:	e8 fb 10 00 00       	call   1260 <printf>
  exit();
     165:	e8 5c 0f 00 00       	call   10c6 <exit>
     16a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000170 <runcmd>:
{
     170:	55                   	push   %ebp
     171:	89 e5                	mov    %esp,%ebp
     173:	53                   	push   %ebx
     174:	83 ec 14             	sub    $0x14,%esp
     177:	8b 5d 08             	mov    0x8(%ebp),%ebx
  if(cmd == 0)
     17a:	85 db                	test   %ebx,%ebx
     17c:	74 3a                	je     1b8 <runcmd+0x48>
  switch(cmd->type){
     17e:	83 3b 05             	cmpl   $0x5,(%ebx)
     181:	0f 87 06 01 00 00    	ja     28d <runcmd+0x11d>
     187:	8b 03                	mov    (%ebx),%eax
     189:	ff 24 85 70 16 00 00 	jmp    *0x1670(,%eax,4)
    if(ecmd->argv[0] == 0)
     190:	8b 43 04             	mov    0x4(%ebx),%eax
     193:	85 c0                	test   %eax,%eax
     195:	74 21                	je     1b8 <runcmd+0x48>
    exec(ecmd->argv[0], ecmd->argv);
     197:	52                   	push   %edx
     198:	52                   	push   %edx
     199:	8d 53 04             	lea    0x4(%ebx),%edx
     19c:	52                   	push   %edx
     19d:	50                   	push   %eax
     19e:	e8 5b 0f 00 00       	call   10fe <exec>
    printf(2, "exec %s failed\n", ecmd->argv[0]);
     1a3:	83 c4 0c             	add    $0xc,%esp
     1a6:	ff 73 04             	pushl  0x4(%ebx)
     1a9:	68 c2 15 00 00       	push   $0x15c2
     1ae:	6a 02                	push   $0x2
     1b0:	e8 ab 10 00 00       	call   1260 <printf>
    break;
     1b5:	83 c4 10             	add    $0x10,%esp
    exit();
     1b8:	e8 09 0f 00 00       	call   10c6 <exit>
  pid = fork();
     1bd:	e8 fc 0e 00 00       	call   10be <fork>
  if(pid == -1)
     1c2:	83 f8 ff             	cmp    $0xffffffff,%eax
     1c5:	0f 84 cf 00 00 00    	je     29a <runcmd+0x12a>
    if(fork1() == 0)
     1cb:	85 c0                	test   %eax,%eax
     1cd:	75 e9                	jne    1b8 <runcmd+0x48>
      runcmd(bcmd->cmd);
     1cf:	83 ec 0c             	sub    $0xc,%esp
     1d2:	ff 73 04             	pushl  0x4(%ebx)
     1d5:	e8 96 ff ff ff       	call   170 <runcmd>
    close(rcmd->fd);
     1da:	83 ec 0c             	sub    $0xc,%esp
     1dd:	ff 73 14             	pushl  0x14(%ebx)
     1e0:	e8 09 0f 00 00       	call   10ee <close>
    if(open(rcmd->file, rcmd->mode) < 0){
     1e5:	59                   	pop    %ecx
     1e6:	58                   	pop    %eax
     1e7:	ff 73 10             	pushl  0x10(%ebx)
     1ea:	ff 73 08             	pushl  0x8(%ebx)
     1ed:	e8 14 0f 00 00       	call   1106 <open>
     1f2:	83 c4 10             	add    $0x10,%esp
     1f5:	85 c0                	test   %eax,%eax
     1f7:	79 d6                	jns    1cf <runcmd+0x5f>
      printf(2, "open %s failed\n", rcmd->file);
     1f9:	52                   	push   %edx
     1fa:	ff 73 08             	pushl  0x8(%ebx)
     1fd:	68 d2 15 00 00       	push   $0x15d2
     202:	6a 02                	push   $0x2
     204:	e8 57 10 00 00       	call   1260 <printf>
      exit();
     209:	e8 b8 0e 00 00       	call   10c6 <exit>
    if(pipe(p) < 0)
     20e:	8d 45 f0             	lea    -0x10(%ebp),%eax
     211:	83 ec 0c             	sub    $0xc,%esp
     214:	50                   	push   %eax
     215:	e8 bc 0e 00 00       	call   10d6 <pipe>
     21a:	83 c4 10             	add    $0x10,%esp
     21d:	85 c0                	test   %eax,%eax
     21f:	0f 88 b0 00 00 00    	js     2d5 <runcmd+0x165>
  pid = fork();
     225:	e8 94 0e 00 00       	call   10be <fork>
  if(pid == -1)
     22a:	83 f8 ff             	cmp    $0xffffffff,%eax
     22d:	74 6b                	je     29a <runcmd+0x12a>
    if(fork1() == 0){
     22f:	85 c0                	test   %eax,%eax
     231:	0f 84 ab 00 00 00    	je     2e2 <runcmd+0x172>
  pid = fork();
     237:	e8 82 0e 00 00       	call   10be <fork>
  if(pid == -1)
     23c:	83 f8 ff             	cmp    $0xffffffff,%eax
     23f:	74 59                	je     29a <runcmd+0x12a>
    if(fork1() == 0){
     241:	85 c0                	test   %eax,%eax
     243:	74 62                	je     2a7 <runcmd+0x137>
    close(p[0]);
     245:	83 ec 0c             	sub    $0xc,%esp
     248:	ff 75 f0             	pushl  -0x10(%ebp)
     24b:	e8 9e 0e 00 00       	call   10ee <close>
    close(p[1]);
     250:	58                   	pop    %eax
     251:	ff 75 f4             	pushl  -0xc(%ebp)
     254:	e8 95 0e 00 00       	call   10ee <close>
    wait();
     259:	e8 70 0e 00 00       	call   10ce <wait>
    wait();
     25e:	e8 6b 0e 00 00       	call   10ce <wait>
    break;
     263:	83 c4 10             	add    $0x10,%esp
     266:	e9 4d ff ff ff       	jmp    1b8 <runcmd+0x48>
  pid = fork();
     26b:	e8 4e 0e 00 00       	call   10be <fork>
  if(pid == -1)
     270:	83 f8 ff             	cmp    $0xffffffff,%eax
     273:	74 25                	je     29a <runcmd+0x12a>
    if(fork1() == 0)
     275:	85 c0                	test   %eax,%eax
     277:	0f 84 52 ff ff ff    	je     1cf <runcmd+0x5f>
    wait();
     27d:	e8 4c 0e 00 00       	call   10ce <wait>
    runcmd(lcmd->right);
     282:	83 ec 0c             	sub    $0xc,%esp
     285:	ff 73 08             	pushl  0x8(%ebx)
     288:	e8 e3 fe ff ff       	call   170 <runcmd>
    panic("runcmd");
     28d:	83 ec 0c             	sub    $0xc,%esp
     290:	68 bb 15 00 00       	push   $0x15bb
     295:	e8 b6 fe ff ff       	call   150 <panic>
    panic("fork");
     29a:	83 ec 0c             	sub    $0xc,%esp
     29d:	68 e2 15 00 00       	push   $0x15e2
     2a2:	e8 a9 fe ff ff       	call   150 <panic>
      close(0);
     2a7:	83 ec 0c             	sub    $0xc,%esp
     2aa:	6a 00                	push   $0x0
     2ac:	e8 3d 0e 00 00       	call   10ee <close>
      dup(p[0]);
     2b1:	5a                   	pop    %edx
     2b2:	ff 75 f0             	pushl  -0x10(%ebp)
     2b5:	e8 84 0e 00 00       	call   113e <dup>
      close(p[0]);
     2ba:	59                   	pop    %ecx
     2bb:	ff 75 f0             	pushl  -0x10(%ebp)
     2be:	e8 2b 0e 00 00       	call   10ee <close>
      close(p[1]);
     2c3:	58                   	pop    %eax
     2c4:	ff 75 f4             	pushl  -0xc(%ebp)
     2c7:	e8 22 0e 00 00       	call   10ee <close>
      runcmd(pcmd->right);
     2cc:	58                   	pop    %eax
     2cd:	ff 73 08             	pushl  0x8(%ebx)
     2d0:	e8 9b fe ff ff       	call   170 <runcmd>
      panic("pipe");
     2d5:	83 ec 0c             	sub    $0xc,%esp
     2d8:	68 e7 15 00 00       	push   $0x15e7
     2dd:	e8 6e fe ff ff       	call   150 <panic>
      close(1);
     2e2:	83 ec 0c             	sub    $0xc,%esp
     2e5:	6a 01                	push   $0x1
     2e7:	e8 02 0e 00 00       	call   10ee <close>
      dup(p[1]);
     2ec:	58                   	pop    %eax
     2ed:	ff 75 f4             	pushl  -0xc(%ebp)
     2f0:	e8 49 0e 00 00       	call   113e <dup>
      close(p[0]);
     2f5:	58                   	pop    %eax
     2f6:	ff 75 f0             	pushl  -0x10(%ebp)
     2f9:	e8 f0 0d 00 00       	call   10ee <close>
      close(p[1]);
     2fe:	58                   	pop    %eax
     2ff:	ff 75 f4             	pushl  -0xc(%ebp)
     302:	e8 e7 0d 00 00       	call   10ee <close>
      runcmd(pcmd->left);
     307:	58                   	pop    %eax
     308:	ff 73 04             	pushl  0x4(%ebx)
     30b:	e8 60 fe ff ff       	call   170 <runcmd>

00000310 <fork1>:
{
     310:	55                   	push   %ebp
     311:	89 e5                	mov    %esp,%ebp
     313:	83 ec 08             	sub    $0x8,%esp
  pid = fork();
     316:	e8 a3 0d 00 00       	call   10be <fork>
  if(pid == -1)
     31b:	83 f8 ff             	cmp    $0xffffffff,%eax
     31e:	74 02                	je     322 <fork1+0x12>
  return pid;
}
     320:	c9                   	leave  
     321:	c3                   	ret    
    panic("fork");
     322:	83 ec 0c             	sub    $0xc,%esp
     325:	68 e2 15 00 00       	push   $0x15e2
     32a:	e8 21 fe ff ff       	call   150 <panic>
     32f:	90                   	nop

00000330 <execcmd>:
//PAGEBREAK!
// Constructors

struct cmd*
execcmd(void)
{
     330:	55                   	push   %ebp
     331:	89 e5                	mov    %esp,%ebp
     333:	53                   	push   %ebx
     334:	83 ec 10             	sub    $0x10,%esp
  struct execcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     337:	6a 54                	push   $0x54
     339:	e8 82 11 00 00       	call   14c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     33e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     341:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     343:	6a 54                	push   $0x54
     345:	6a 00                	push   $0x0
     347:	50                   	push   %eax
     348:	e8 23 08 00 00       	call   b70 <memset>
  cmd->type = EXEC;
     34d:	c7 03 01 00 00 00    	movl   $0x1,(%ebx)
  return (struct cmd*)cmd;
}
     353:	89 d8                	mov    %ebx,%eax
     355:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     358:	c9                   	leave  
     359:	c3                   	ret    
     35a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

00000360 <redircmd>:

struct cmd*
redircmd(struct cmd *subcmd, char *file, char *efile, int mode, int fd)
{
     360:	55                   	push   %ebp
     361:	89 e5                	mov    %esp,%ebp
     363:	53                   	push   %ebx
     364:	83 ec 10             	sub    $0x10,%esp
  struct redircmd *cmd;

  cmd = malloc(sizeof(*cmd));
     367:	6a 18                	push   $0x18
     369:	e8 52 11 00 00       	call   14c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     36e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     371:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     373:	6a 18                	push   $0x18
     375:	6a 00                	push   $0x0
     377:	50                   	push   %eax
     378:	e8 f3 07 00 00       	call   b70 <memset>
  cmd->type = REDIR;
  cmd->cmd = subcmd;
     37d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = REDIR;
     380:	c7 03 02 00 00 00    	movl   $0x2,(%ebx)
  cmd->cmd = subcmd;
     386:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->file = file;
     389:	8b 45 0c             	mov    0xc(%ebp),%eax
     38c:	89 43 08             	mov    %eax,0x8(%ebx)
  cmd->efile = efile;
     38f:	8b 45 10             	mov    0x10(%ebp),%eax
     392:	89 43 0c             	mov    %eax,0xc(%ebx)
  cmd->mode = mode;
     395:	8b 45 14             	mov    0x14(%ebp),%eax
     398:	89 43 10             	mov    %eax,0x10(%ebx)
  cmd->fd = fd;
     39b:	8b 45 18             	mov    0x18(%ebp),%eax
     39e:	89 43 14             	mov    %eax,0x14(%ebx)
  return (struct cmd*)cmd;
}
     3a1:	89 d8                	mov    %ebx,%eax
     3a3:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3a6:	c9                   	leave  
     3a7:	c3                   	ret    
     3a8:	90                   	nop
     3a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003b0 <pipecmd>:

struct cmd*
pipecmd(struct cmd *left, struct cmd *right)
{
     3b0:	55                   	push   %ebp
     3b1:	89 e5                	mov    %esp,%ebp
     3b3:	53                   	push   %ebx
     3b4:	83 ec 10             	sub    $0x10,%esp
  struct pipecmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3b7:	6a 0c                	push   $0xc
     3b9:	e8 02 11 00 00       	call   14c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3be:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     3c1:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     3c3:	6a 0c                	push   $0xc
     3c5:	6a 00                	push   $0x0
     3c7:	50                   	push   %eax
     3c8:	e8 a3 07 00 00       	call   b70 <memset>
  cmd->type = PIPE;
  cmd->left = left;
     3cd:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = PIPE;
     3d0:	c7 03 03 00 00 00    	movl   $0x3,(%ebx)
  cmd->left = left;
     3d6:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     3d9:	8b 45 0c             	mov    0xc(%ebp),%eax
     3dc:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     3df:	89 d8                	mov    %ebx,%eax
     3e1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     3e4:	c9                   	leave  
     3e5:	c3                   	ret    
     3e6:	8d 76 00             	lea    0x0(%esi),%esi
     3e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003f0 <listcmd>:

struct cmd*
listcmd(struct cmd *left, struct cmd *right)
{
     3f0:	55                   	push   %ebp
     3f1:	89 e5                	mov    %esp,%ebp
     3f3:	53                   	push   %ebx
     3f4:	83 ec 10             	sub    $0x10,%esp
  struct listcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     3f7:	6a 0c                	push   $0xc
     3f9:	e8 c2 10 00 00       	call   14c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     3fe:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     401:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     403:	6a 0c                	push   $0xc
     405:	6a 00                	push   $0x0
     407:	50                   	push   %eax
     408:	e8 63 07 00 00       	call   b70 <memset>
  cmd->type = LIST;
  cmd->left = left;
     40d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = LIST;
     410:	c7 03 04 00 00 00    	movl   $0x4,(%ebx)
  cmd->left = left;
     416:	89 43 04             	mov    %eax,0x4(%ebx)
  cmd->right = right;
     419:	8b 45 0c             	mov    0xc(%ebp),%eax
     41c:	89 43 08             	mov    %eax,0x8(%ebx)
  return (struct cmd*)cmd;
}
     41f:	89 d8                	mov    %ebx,%eax
     421:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     424:	c9                   	leave  
     425:	c3                   	ret    
     426:	8d 76 00             	lea    0x0(%esi),%esi
     429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <backcmd>:

struct cmd*
backcmd(struct cmd *subcmd)
{
     430:	55                   	push   %ebp
     431:	89 e5                	mov    %esp,%ebp
     433:	53                   	push   %ebx
     434:	83 ec 10             	sub    $0x10,%esp
  struct backcmd *cmd;

  cmd = malloc(sizeof(*cmd));
     437:	6a 08                	push   $0x8
     439:	e8 82 10 00 00       	call   14c0 <malloc>
  memset(cmd, 0, sizeof(*cmd));
     43e:	83 c4 0c             	add    $0xc,%esp
  cmd = malloc(sizeof(*cmd));
     441:	89 c3                	mov    %eax,%ebx
  memset(cmd, 0, sizeof(*cmd));
     443:	6a 08                	push   $0x8
     445:	6a 00                	push   $0x0
     447:	50                   	push   %eax
     448:	e8 23 07 00 00       	call   b70 <memset>
  cmd->type = BACK;
  cmd->cmd = subcmd;
     44d:	8b 45 08             	mov    0x8(%ebp),%eax
  cmd->type = BACK;
     450:	c7 03 05 00 00 00    	movl   $0x5,(%ebx)
  cmd->cmd = subcmd;
     456:	89 43 04             	mov    %eax,0x4(%ebx)
  return (struct cmd*)cmd;
}
     459:	89 d8                	mov    %ebx,%eax
     45b:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     45e:	c9                   	leave  
     45f:	c3                   	ret    

00000460 <gettoken>:
char whitespace[] = " \t\r\n\v";
char symbols[] = "<|>&;()";

int
gettoken(char **ps, char *es, char **q, char **eq)
{
     460:	55                   	push   %ebp
     461:	89 e5                	mov    %esp,%ebp
     463:	57                   	push   %edi
     464:	56                   	push   %esi
     465:	53                   	push   %ebx
     466:	83 ec 0c             	sub    $0xc,%esp
  char *s;
  int ret;

  s = *ps;
     469:	8b 45 08             	mov    0x8(%ebp),%eax
{
     46c:	8b 5d 0c             	mov    0xc(%ebp),%ebx
     46f:	8b 7d 10             	mov    0x10(%ebp),%edi
  s = *ps;
     472:	8b 30                	mov    (%eax),%esi
  while(s < es && strchr(whitespace, *s))
     474:	39 de                	cmp    %ebx,%esi
     476:	72 0f                	jb     487 <gettoken+0x27>
     478:	eb 25                	jmp    49f <gettoken+0x3f>
     47a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    s++;
     480:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     483:	39 f3                	cmp    %esi,%ebx
     485:	74 18                	je     49f <gettoken+0x3f>
     487:	0f be 06             	movsbl (%esi),%eax
     48a:	83 ec 08             	sub    $0x8,%esp
     48d:	50                   	push   %eax
     48e:	68 78 1d 00 00       	push   $0x1d78
     493:	e8 f8 06 00 00       	call   b90 <strchr>
     498:	83 c4 10             	add    $0x10,%esp
     49b:	85 c0                	test   %eax,%eax
     49d:	75 e1                	jne    480 <gettoken+0x20>
  if(q)
     49f:	85 ff                	test   %edi,%edi
     4a1:	74 02                	je     4a5 <gettoken+0x45>
    *q = s;
     4a3:	89 37                	mov    %esi,(%edi)
  ret = *s;
     4a5:	0f be 06             	movsbl (%esi),%eax
  switch(*s){
     4a8:	3c 29                	cmp    $0x29,%al
     4aa:	7f 54                	jg     500 <gettoken+0xa0>
     4ac:	3c 28                	cmp    $0x28,%al
     4ae:	0f 8d c8 00 00 00    	jge    57c <gettoken+0x11c>
     4b4:	31 ff                	xor    %edi,%edi
     4b6:	84 c0                	test   %al,%al
     4b8:	0f 85 d2 00 00 00    	jne    590 <gettoken+0x130>
    ret = 'a';
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
      s++;
    break;
  }
  if(eq)
     4be:	8b 55 14             	mov    0x14(%ebp),%edx
     4c1:	85 d2                	test   %edx,%edx
     4c3:	74 05                	je     4ca <gettoken+0x6a>
    *eq = s;
     4c5:	8b 45 14             	mov    0x14(%ebp),%eax
     4c8:	89 30                	mov    %esi,(%eax)

  while(s < es && strchr(whitespace, *s))
     4ca:	39 de                	cmp    %ebx,%esi
     4cc:	72 09                	jb     4d7 <gettoken+0x77>
     4ce:	eb 1f                	jmp    4ef <gettoken+0x8f>
    s++;
     4d0:	83 c6 01             	add    $0x1,%esi
  while(s < es && strchr(whitespace, *s))
     4d3:	39 f3                	cmp    %esi,%ebx
     4d5:	74 18                	je     4ef <gettoken+0x8f>
     4d7:	0f be 06             	movsbl (%esi),%eax
     4da:	83 ec 08             	sub    $0x8,%esp
     4dd:	50                   	push   %eax
     4de:	68 78 1d 00 00       	push   $0x1d78
     4e3:	e8 a8 06 00 00       	call   b90 <strchr>
     4e8:	83 c4 10             	add    $0x10,%esp
     4eb:	85 c0                	test   %eax,%eax
     4ed:	75 e1                	jne    4d0 <gettoken+0x70>
  *ps = s;
     4ef:	8b 45 08             	mov    0x8(%ebp),%eax
     4f2:	89 30                	mov    %esi,(%eax)
  return ret;
}
     4f4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     4f7:	89 f8                	mov    %edi,%eax
     4f9:	5b                   	pop    %ebx
     4fa:	5e                   	pop    %esi
     4fb:	5f                   	pop    %edi
     4fc:	5d                   	pop    %ebp
     4fd:	c3                   	ret    
     4fe:	66 90                	xchg   %ax,%ax
  switch(*s){
     500:	3c 3e                	cmp    $0x3e,%al
     502:	75 1c                	jne    520 <gettoken+0xc0>
    if(*s == '>'){
     504:	80 7e 01 3e          	cmpb   $0x3e,0x1(%esi)
    s++;
     508:	8d 46 01             	lea    0x1(%esi),%eax
    if(*s == '>'){
     50b:	0f 84 a4 00 00 00    	je     5b5 <gettoken+0x155>
    s++;
     511:	89 c6                	mov    %eax,%esi
     513:	bf 3e 00 00 00       	mov    $0x3e,%edi
     518:	eb a4                	jmp    4be <gettoken+0x5e>
     51a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  switch(*s){
     520:	7f 56                	jg     578 <gettoken+0x118>
     522:	8d 48 c5             	lea    -0x3b(%eax),%ecx
     525:	80 f9 01             	cmp    $0x1,%cl
     528:	76 52                	jbe    57c <gettoken+0x11c>
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     52a:	39 f3                	cmp    %esi,%ebx
     52c:	77 24                	ja     552 <gettoken+0xf2>
     52e:	eb 70                	jmp    5a0 <gettoken+0x140>
     530:	0f be 06             	movsbl (%esi),%eax
     533:	83 ec 08             	sub    $0x8,%esp
     536:	50                   	push   %eax
     537:	68 70 1d 00 00       	push   $0x1d70
     53c:	e8 4f 06 00 00       	call   b90 <strchr>
     541:	83 c4 10             	add    $0x10,%esp
     544:	85 c0                	test   %eax,%eax
     546:	75 1f                	jne    567 <gettoken+0x107>
      s++;
     548:	83 c6 01             	add    $0x1,%esi
    while(s < es && !strchr(whitespace, *s) && !strchr(symbols, *s))
     54b:	39 f3                	cmp    %esi,%ebx
     54d:	74 51                	je     5a0 <gettoken+0x140>
     54f:	0f be 06             	movsbl (%esi),%eax
     552:	83 ec 08             	sub    $0x8,%esp
     555:	50                   	push   %eax
     556:	68 78 1d 00 00       	push   $0x1d78
     55b:	e8 30 06 00 00       	call   b90 <strchr>
     560:	83 c4 10             	add    $0x10,%esp
     563:	85 c0                	test   %eax,%eax
     565:	74 c9                	je     530 <gettoken+0xd0>
    ret = 'a';
     567:	bf 61 00 00 00       	mov    $0x61,%edi
     56c:	e9 4d ff ff ff       	jmp    4be <gettoken+0x5e>
     571:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  switch(*s){
     578:	3c 7c                	cmp    $0x7c,%al
     57a:	75 ae                	jne    52a <gettoken+0xca>
  ret = *s;
     57c:	0f be f8             	movsbl %al,%edi
    s++;
     57f:	83 c6 01             	add    $0x1,%esi
    break;
     582:	e9 37 ff ff ff       	jmp    4be <gettoken+0x5e>
     587:	89 f6                	mov    %esi,%esi
     589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  switch(*s){
     590:	3c 26                	cmp    $0x26,%al
     592:	75 96                	jne    52a <gettoken+0xca>
     594:	eb e6                	jmp    57c <gettoken+0x11c>
     596:	8d 76 00             	lea    0x0(%esi),%esi
     599:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
  if(eq)
     5a0:	8b 45 14             	mov    0x14(%ebp),%eax
     5a3:	bf 61 00 00 00       	mov    $0x61,%edi
     5a8:	85 c0                	test   %eax,%eax
     5aa:	0f 85 15 ff ff ff    	jne    4c5 <gettoken+0x65>
     5b0:	e9 3a ff ff ff       	jmp    4ef <gettoken+0x8f>
      s++;
     5b5:	83 c6 02             	add    $0x2,%esi
      ret = '+';
     5b8:	bf 2b 00 00 00       	mov    $0x2b,%edi
     5bd:	e9 fc fe ff ff       	jmp    4be <gettoken+0x5e>
     5c2:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     5c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000005d0 <peek>:

int
peek(char **ps, char *es, char *toks)
{
     5d0:	55                   	push   %ebp
     5d1:	89 e5                	mov    %esp,%ebp
     5d3:	57                   	push   %edi
     5d4:	56                   	push   %esi
     5d5:	53                   	push   %ebx
     5d6:	83 ec 0c             	sub    $0xc,%esp
     5d9:	8b 7d 08             	mov    0x8(%ebp),%edi
     5dc:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *s;

  s = *ps;
     5df:	8b 1f                	mov    (%edi),%ebx
  while(s < es && strchr(whitespace, *s))
     5e1:	39 f3                	cmp    %esi,%ebx
     5e3:	72 12                	jb     5f7 <peek+0x27>
     5e5:	eb 28                	jmp    60f <peek+0x3f>
     5e7:	89 f6                	mov    %esi,%esi
     5e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    s++;
     5f0:	83 c3 01             	add    $0x1,%ebx
  while(s < es && strchr(whitespace, *s))
     5f3:	39 de                	cmp    %ebx,%esi
     5f5:	74 18                	je     60f <peek+0x3f>
     5f7:	0f be 03             	movsbl (%ebx),%eax
     5fa:	83 ec 08             	sub    $0x8,%esp
     5fd:	50                   	push   %eax
     5fe:	68 78 1d 00 00       	push   $0x1d78
     603:	e8 88 05 00 00       	call   b90 <strchr>
     608:	83 c4 10             	add    $0x10,%esp
     60b:	85 c0                	test   %eax,%eax
     60d:	75 e1                	jne    5f0 <peek+0x20>
  *ps = s;
     60f:	89 1f                	mov    %ebx,(%edi)
  return *s && strchr(toks, *s);
     611:	0f be 13             	movsbl (%ebx),%edx
     614:	31 c0                	xor    %eax,%eax
     616:	84 d2                	test   %dl,%dl
     618:	74 17                	je     631 <peek+0x61>
     61a:	83 ec 08             	sub    $0x8,%esp
     61d:	52                   	push   %edx
     61e:	ff 75 10             	pushl  0x10(%ebp)
     621:	e8 6a 05 00 00       	call   b90 <strchr>
     626:	83 c4 10             	add    $0x10,%esp
     629:	85 c0                	test   %eax,%eax
     62b:	0f 95 c0             	setne  %al
     62e:	0f b6 c0             	movzbl %al,%eax
}
     631:	8d 65 f4             	lea    -0xc(%ebp),%esp
     634:	5b                   	pop    %ebx
     635:	5e                   	pop    %esi
     636:	5f                   	pop    %edi
     637:	5d                   	pop    %ebp
     638:	c3                   	ret    
     639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000640 <parseredirs>:
  return cmd;
}

struct cmd*
parseredirs(struct cmd *cmd, char **ps, char *es)
{
     640:	55                   	push   %ebp
     641:	89 e5                	mov    %esp,%ebp
     643:	57                   	push   %edi
     644:	56                   	push   %esi
     645:	53                   	push   %ebx
     646:	83 ec 1c             	sub    $0x1c,%esp
     649:	8b 75 0c             	mov    0xc(%ebp),%esi
     64c:	8b 5d 10             	mov    0x10(%ebp),%ebx
     64f:	90                   	nop
  int tok;
  char *q, *eq;

  while(peek(ps, es, "<>")){
     650:	83 ec 04             	sub    $0x4,%esp
     653:	68 09 16 00 00       	push   $0x1609
     658:	53                   	push   %ebx
     659:	56                   	push   %esi
     65a:	e8 71 ff ff ff       	call   5d0 <peek>
     65f:	83 c4 10             	add    $0x10,%esp
     662:	85 c0                	test   %eax,%eax
     664:	74 6a                	je     6d0 <parseredirs+0x90>
    tok = gettoken(ps, es, 0, 0);
     666:	6a 00                	push   $0x0
     668:	6a 00                	push   $0x0
     66a:	53                   	push   %ebx
     66b:	56                   	push   %esi
     66c:	e8 ef fd ff ff       	call   460 <gettoken>
     671:	89 c7                	mov    %eax,%edi
    if(gettoken(ps, es, &q, &eq) != 'a')
     673:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     676:	50                   	push   %eax
     677:	8d 45 e0             	lea    -0x20(%ebp),%eax
     67a:	50                   	push   %eax
     67b:	53                   	push   %ebx
     67c:	56                   	push   %esi
     67d:	e8 de fd ff ff       	call   460 <gettoken>
     682:	83 c4 20             	add    $0x20,%esp
     685:	83 f8 61             	cmp    $0x61,%eax
     688:	75 51                	jne    6db <parseredirs+0x9b>
      panic("missing file for redirection");
    switch(tok){
     68a:	83 ff 3c             	cmp    $0x3c,%edi
     68d:	74 31                	je     6c0 <parseredirs+0x80>
     68f:	83 ff 3e             	cmp    $0x3e,%edi
     692:	74 05                	je     699 <parseredirs+0x59>
     694:	83 ff 2b             	cmp    $0x2b,%edi
     697:	75 b7                	jne    650 <parseredirs+0x10>
      break;
    case '>':
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
      break;
    case '+':  // >>
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     699:	83 ec 0c             	sub    $0xc,%esp
     69c:	6a 01                	push   $0x1
     69e:	68 01 02 00 00       	push   $0x201
     6a3:	ff 75 e4             	pushl  -0x1c(%ebp)
     6a6:	ff 75 e0             	pushl  -0x20(%ebp)
     6a9:	ff 75 08             	pushl  0x8(%ebp)
     6ac:	e8 af fc ff ff       	call   360 <redircmd>
      break;
     6b1:	83 c4 20             	add    $0x20,%esp
      cmd = redircmd(cmd, q, eq, O_WRONLY|O_CREATE, 1);
     6b4:	89 45 08             	mov    %eax,0x8(%ebp)
      break;
     6b7:	eb 97                	jmp    650 <parseredirs+0x10>
     6b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
      cmd = redircmd(cmd, q, eq, O_RDONLY, 0);
     6c0:	83 ec 0c             	sub    $0xc,%esp
     6c3:	6a 00                	push   $0x0
     6c5:	6a 00                	push   $0x0
     6c7:	eb da                	jmp    6a3 <parseredirs+0x63>
     6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    }
  }
  return cmd;
}
     6d0:	8b 45 08             	mov    0x8(%ebp),%eax
     6d3:	8d 65 f4             	lea    -0xc(%ebp),%esp
     6d6:	5b                   	pop    %ebx
     6d7:	5e                   	pop    %esi
     6d8:	5f                   	pop    %edi
     6d9:	5d                   	pop    %ebp
     6da:	c3                   	ret    
      panic("missing file for redirection");
     6db:	83 ec 0c             	sub    $0xc,%esp
     6de:	68 ec 15 00 00       	push   $0x15ec
     6e3:	e8 68 fa ff ff       	call   150 <panic>
     6e8:	90                   	nop
     6e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000006f0 <parseexec>:
  return cmd;
}

struct cmd*
parseexec(char **ps, char *es)
{
     6f0:	55                   	push   %ebp
     6f1:	89 e5                	mov    %esp,%ebp
     6f3:	57                   	push   %edi
     6f4:	56                   	push   %esi
     6f5:	53                   	push   %ebx
     6f6:	83 ec 30             	sub    $0x30,%esp
     6f9:	8b 75 08             	mov    0x8(%ebp),%esi
     6fc:	8b 7d 0c             	mov    0xc(%ebp),%edi
  char *q, *eq;
  int tok, argc;
  struct execcmd *cmd;
  struct cmd *ret;

  if(peek(ps, es, "("))
     6ff:	68 0c 16 00 00       	push   $0x160c
     704:	57                   	push   %edi
     705:	56                   	push   %esi
     706:	e8 c5 fe ff ff       	call   5d0 <peek>
     70b:	83 c4 10             	add    $0x10,%esp
     70e:	85 c0                	test   %eax,%eax
     710:	0f 85 92 00 00 00    	jne    7a8 <parseexec+0xb8>
     716:	89 c3                	mov    %eax,%ebx
    return parseblock(ps, es);

  ret = execcmd();
     718:	e8 13 fc ff ff       	call   330 <execcmd>
  cmd = (struct execcmd*)ret;

  argc = 0;
  ret = parseredirs(ret, ps, es);
     71d:	83 ec 04             	sub    $0x4,%esp
  ret = execcmd();
     720:	89 45 d0             	mov    %eax,-0x30(%ebp)
  ret = parseredirs(ret, ps, es);
     723:	57                   	push   %edi
     724:	56                   	push   %esi
     725:	50                   	push   %eax
     726:	e8 15 ff ff ff       	call   640 <parseredirs>
     72b:	83 c4 10             	add    $0x10,%esp
     72e:	89 45 d4             	mov    %eax,-0x2c(%ebp)
     731:	eb 18                	jmp    74b <parseexec+0x5b>
     733:	90                   	nop
     734:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    cmd->argv[argc] = q;
    cmd->eargv[argc] = eq;
    argc++;
    if(argc >= MAXARGS)
      panic("too many args");
    ret = parseredirs(ret, ps, es);
     738:	83 ec 04             	sub    $0x4,%esp
     73b:	57                   	push   %edi
     73c:	56                   	push   %esi
     73d:	ff 75 d4             	pushl  -0x2c(%ebp)
     740:	e8 fb fe ff ff       	call   640 <parseredirs>
     745:	83 c4 10             	add    $0x10,%esp
     748:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  while(!peek(ps, es, "|)&;")){
     74b:	83 ec 04             	sub    $0x4,%esp
     74e:	68 23 16 00 00       	push   $0x1623
     753:	57                   	push   %edi
     754:	56                   	push   %esi
     755:	e8 76 fe ff ff       	call   5d0 <peek>
     75a:	83 c4 10             	add    $0x10,%esp
     75d:	85 c0                	test   %eax,%eax
     75f:	75 67                	jne    7c8 <parseexec+0xd8>
    if((tok=gettoken(ps, es, &q, &eq)) == 0)
     761:	8d 45 e4             	lea    -0x1c(%ebp),%eax
     764:	50                   	push   %eax
     765:	8d 45 e0             	lea    -0x20(%ebp),%eax
     768:	50                   	push   %eax
     769:	57                   	push   %edi
     76a:	56                   	push   %esi
     76b:	e8 f0 fc ff ff       	call   460 <gettoken>
     770:	83 c4 10             	add    $0x10,%esp
     773:	85 c0                	test   %eax,%eax
     775:	74 51                	je     7c8 <parseexec+0xd8>
    if(tok != 'a')
     777:	83 f8 61             	cmp    $0x61,%eax
     77a:	75 6b                	jne    7e7 <parseexec+0xf7>
    cmd->argv[argc] = q;
     77c:	8b 45 e0             	mov    -0x20(%ebp),%eax
     77f:	8b 55 d0             	mov    -0x30(%ebp),%edx
     782:	89 44 9a 04          	mov    %eax,0x4(%edx,%ebx,4)
    cmd->eargv[argc] = eq;
     786:	8b 45 e4             	mov    -0x1c(%ebp),%eax
     789:	89 44 9a 2c          	mov    %eax,0x2c(%edx,%ebx,4)
    argc++;
     78d:	83 c3 01             	add    $0x1,%ebx
    if(argc >= MAXARGS)
     790:	83 fb 0a             	cmp    $0xa,%ebx
     793:	75 a3                	jne    738 <parseexec+0x48>
      panic("too many args");
     795:	83 ec 0c             	sub    $0xc,%esp
     798:	68 15 16 00 00       	push   $0x1615
     79d:	e8 ae f9 ff ff       	call   150 <panic>
     7a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    return parseblock(ps, es);
     7a8:	83 ec 08             	sub    $0x8,%esp
     7ab:	57                   	push   %edi
     7ac:	56                   	push   %esi
     7ad:	e8 5e 01 00 00       	call   910 <parseblock>
     7b2:	83 c4 10             	add    $0x10,%esp
     7b5:	89 45 d4             	mov    %eax,-0x2c(%ebp)
  }
  cmd->argv[argc] = 0;
  cmd->eargv[argc] = 0;
  return ret;
}
     7b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7bb:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7be:	5b                   	pop    %ebx
     7bf:	5e                   	pop    %esi
     7c0:	5f                   	pop    %edi
     7c1:	5d                   	pop    %ebp
     7c2:	c3                   	ret    
     7c3:	90                   	nop
     7c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     7c8:	8b 45 d0             	mov    -0x30(%ebp),%eax
     7cb:	8d 04 98             	lea    (%eax,%ebx,4),%eax
  cmd->argv[argc] = 0;
     7ce:	c7 40 04 00 00 00 00 	movl   $0x0,0x4(%eax)
  cmd->eargv[argc] = 0;
     7d5:	c7 40 2c 00 00 00 00 	movl   $0x0,0x2c(%eax)
}
     7dc:	8b 45 d4             	mov    -0x2c(%ebp),%eax
     7df:	8d 65 f4             	lea    -0xc(%ebp),%esp
     7e2:	5b                   	pop    %ebx
     7e3:	5e                   	pop    %esi
     7e4:	5f                   	pop    %edi
     7e5:	5d                   	pop    %ebp
     7e6:	c3                   	ret    
      panic("syntax");
     7e7:	83 ec 0c             	sub    $0xc,%esp
     7ea:	68 0e 16 00 00       	push   $0x160e
     7ef:	e8 5c f9 ff ff       	call   150 <panic>
     7f4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     7fa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000800 <parsepipe>:
{
     800:	55                   	push   %ebp
     801:	89 e5                	mov    %esp,%ebp
     803:	57                   	push   %edi
     804:	56                   	push   %esi
     805:	53                   	push   %ebx
     806:	83 ec 14             	sub    $0x14,%esp
     809:	8b 5d 08             	mov    0x8(%ebp),%ebx
     80c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parseexec(ps, es);
     80f:	56                   	push   %esi
     810:	53                   	push   %ebx
     811:	e8 da fe ff ff       	call   6f0 <parseexec>
  if(peek(ps, es, "|")){
     816:	83 c4 0c             	add    $0xc,%esp
  cmd = parseexec(ps, es);
     819:	89 c7                	mov    %eax,%edi
  if(peek(ps, es, "|")){
     81b:	68 28 16 00 00       	push   $0x1628
     820:	56                   	push   %esi
     821:	53                   	push   %ebx
     822:	e8 a9 fd ff ff       	call   5d0 <peek>
     827:	83 c4 10             	add    $0x10,%esp
     82a:	85 c0                	test   %eax,%eax
     82c:	75 12                	jne    840 <parsepipe+0x40>
}
     82e:	8d 65 f4             	lea    -0xc(%ebp),%esp
     831:	89 f8                	mov    %edi,%eax
     833:	5b                   	pop    %ebx
     834:	5e                   	pop    %esi
     835:	5f                   	pop    %edi
     836:	5d                   	pop    %ebp
     837:	c3                   	ret    
     838:	90                   	nop
     839:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    gettoken(ps, es, 0, 0);
     840:	6a 00                	push   $0x0
     842:	6a 00                	push   $0x0
     844:	56                   	push   %esi
     845:	53                   	push   %ebx
     846:	e8 15 fc ff ff       	call   460 <gettoken>
    cmd = pipecmd(cmd, parsepipe(ps, es));
     84b:	58                   	pop    %eax
     84c:	5a                   	pop    %edx
     84d:	56                   	push   %esi
     84e:	53                   	push   %ebx
     84f:	e8 ac ff ff ff       	call   800 <parsepipe>
     854:	89 7d 08             	mov    %edi,0x8(%ebp)
     857:	89 45 0c             	mov    %eax,0xc(%ebp)
     85a:	83 c4 10             	add    $0x10,%esp
}
     85d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     860:	5b                   	pop    %ebx
     861:	5e                   	pop    %esi
     862:	5f                   	pop    %edi
     863:	5d                   	pop    %ebp
    cmd = pipecmd(cmd, parsepipe(ps, es));
     864:	e9 47 fb ff ff       	jmp    3b0 <pipecmd>
     869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000870 <parseline>:
{
     870:	55                   	push   %ebp
     871:	89 e5                	mov    %esp,%ebp
     873:	57                   	push   %edi
     874:	56                   	push   %esi
     875:	53                   	push   %ebx
     876:	83 ec 14             	sub    $0x14,%esp
     879:	8b 5d 08             	mov    0x8(%ebp),%ebx
     87c:	8b 75 0c             	mov    0xc(%ebp),%esi
  cmd = parsepipe(ps, es);
     87f:	56                   	push   %esi
     880:	53                   	push   %ebx
     881:	e8 7a ff ff ff       	call   800 <parsepipe>
  while(peek(ps, es, "&")){
     886:	83 c4 10             	add    $0x10,%esp
  cmd = parsepipe(ps, es);
     889:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     88b:	eb 1b                	jmp    8a8 <parseline+0x38>
     88d:	8d 76 00             	lea    0x0(%esi),%esi
    gettoken(ps, es, 0, 0);
     890:	6a 00                	push   $0x0
     892:	6a 00                	push   $0x0
     894:	56                   	push   %esi
     895:	53                   	push   %ebx
     896:	e8 c5 fb ff ff       	call   460 <gettoken>
    cmd = backcmd(cmd);
     89b:	89 3c 24             	mov    %edi,(%esp)
     89e:	e8 8d fb ff ff       	call   430 <backcmd>
     8a3:	83 c4 10             	add    $0x10,%esp
     8a6:	89 c7                	mov    %eax,%edi
  while(peek(ps, es, "&")){
     8a8:	83 ec 04             	sub    $0x4,%esp
     8ab:	68 2a 16 00 00       	push   $0x162a
     8b0:	56                   	push   %esi
     8b1:	53                   	push   %ebx
     8b2:	e8 19 fd ff ff       	call   5d0 <peek>
     8b7:	83 c4 10             	add    $0x10,%esp
     8ba:	85 c0                	test   %eax,%eax
     8bc:	75 d2                	jne    890 <parseline+0x20>
  if(peek(ps, es, ";")){
     8be:	83 ec 04             	sub    $0x4,%esp
     8c1:	68 26 16 00 00       	push   $0x1626
     8c6:	56                   	push   %esi
     8c7:	53                   	push   %ebx
     8c8:	e8 03 fd ff ff       	call   5d0 <peek>
     8cd:	83 c4 10             	add    $0x10,%esp
     8d0:	85 c0                	test   %eax,%eax
     8d2:	75 0c                	jne    8e0 <parseline+0x70>
}
     8d4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     8d7:	89 f8                	mov    %edi,%eax
     8d9:	5b                   	pop    %ebx
     8da:	5e                   	pop    %esi
     8db:	5f                   	pop    %edi
     8dc:	5d                   	pop    %ebp
     8dd:	c3                   	ret    
     8de:	66 90                	xchg   %ax,%ax
    gettoken(ps, es, 0, 0);
     8e0:	6a 00                	push   $0x0
     8e2:	6a 00                	push   $0x0
     8e4:	56                   	push   %esi
     8e5:	53                   	push   %ebx
     8e6:	e8 75 fb ff ff       	call   460 <gettoken>
    cmd = listcmd(cmd, parseline(ps, es));
     8eb:	58                   	pop    %eax
     8ec:	5a                   	pop    %edx
     8ed:	56                   	push   %esi
     8ee:	53                   	push   %ebx
     8ef:	e8 7c ff ff ff       	call   870 <parseline>
     8f4:	89 7d 08             	mov    %edi,0x8(%ebp)
     8f7:	89 45 0c             	mov    %eax,0xc(%ebp)
     8fa:	83 c4 10             	add    $0x10,%esp
}
     8fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
     900:	5b                   	pop    %ebx
     901:	5e                   	pop    %esi
     902:	5f                   	pop    %edi
     903:	5d                   	pop    %ebp
    cmd = listcmd(cmd, parseline(ps, es));
     904:	e9 e7 fa ff ff       	jmp    3f0 <listcmd>
     909:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000910 <parseblock>:
{
     910:	55                   	push   %ebp
     911:	89 e5                	mov    %esp,%ebp
     913:	57                   	push   %edi
     914:	56                   	push   %esi
     915:	53                   	push   %ebx
     916:	83 ec 10             	sub    $0x10,%esp
     919:	8b 5d 08             	mov    0x8(%ebp),%ebx
     91c:	8b 75 0c             	mov    0xc(%ebp),%esi
  if(!peek(ps, es, "("))
     91f:	68 0c 16 00 00       	push   $0x160c
     924:	56                   	push   %esi
     925:	53                   	push   %ebx
     926:	e8 a5 fc ff ff       	call   5d0 <peek>
     92b:	83 c4 10             	add    $0x10,%esp
     92e:	85 c0                	test   %eax,%eax
     930:	74 4a                	je     97c <parseblock+0x6c>
  gettoken(ps, es, 0, 0);
     932:	6a 00                	push   $0x0
     934:	6a 00                	push   $0x0
     936:	56                   	push   %esi
     937:	53                   	push   %ebx
     938:	e8 23 fb ff ff       	call   460 <gettoken>
  cmd = parseline(ps, es);
     93d:	58                   	pop    %eax
     93e:	5a                   	pop    %edx
     93f:	56                   	push   %esi
     940:	53                   	push   %ebx
     941:	e8 2a ff ff ff       	call   870 <parseline>
  if(!peek(ps, es, ")"))
     946:	83 c4 0c             	add    $0xc,%esp
  cmd = parseline(ps, es);
     949:	89 c7                	mov    %eax,%edi
  if(!peek(ps, es, ")"))
     94b:	68 48 16 00 00       	push   $0x1648
     950:	56                   	push   %esi
     951:	53                   	push   %ebx
     952:	e8 79 fc ff ff       	call   5d0 <peek>
     957:	83 c4 10             	add    $0x10,%esp
     95a:	85 c0                	test   %eax,%eax
     95c:	74 2b                	je     989 <parseblock+0x79>
  gettoken(ps, es, 0, 0);
     95e:	6a 00                	push   $0x0
     960:	6a 00                	push   $0x0
     962:	56                   	push   %esi
     963:	53                   	push   %ebx
     964:	e8 f7 fa ff ff       	call   460 <gettoken>
  cmd = parseredirs(cmd, ps, es);
     969:	83 c4 0c             	add    $0xc,%esp
     96c:	56                   	push   %esi
     96d:	53                   	push   %ebx
     96e:	57                   	push   %edi
     96f:	e8 cc fc ff ff       	call   640 <parseredirs>
}
     974:	8d 65 f4             	lea    -0xc(%ebp),%esp
     977:	5b                   	pop    %ebx
     978:	5e                   	pop    %esi
     979:	5f                   	pop    %edi
     97a:	5d                   	pop    %ebp
     97b:	c3                   	ret    
    panic("parseblock");
     97c:	83 ec 0c             	sub    $0xc,%esp
     97f:	68 2c 16 00 00       	push   $0x162c
     984:	e8 c7 f7 ff ff       	call   150 <panic>
    panic("syntax - missing )");
     989:	83 ec 0c             	sub    $0xc,%esp
     98c:	68 37 16 00 00       	push   $0x1637
     991:	e8 ba f7 ff ff       	call   150 <panic>
     996:	8d 76 00             	lea    0x0(%esi),%esi
     999:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000009a0 <nulterminate>:

// NUL-terminate all the counted strings.
struct cmd*
nulterminate(struct cmd *cmd)
{
     9a0:	55                   	push   %ebp
     9a1:	89 e5                	mov    %esp,%ebp
     9a3:	53                   	push   %ebx
     9a4:	83 ec 04             	sub    $0x4,%esp
     9a7:	8b 5d 08             	mov    0x8(%ebp),%ebx
  struct execcmd *ecmd;
  struct listcmd *lcmd;
  struct pipecmd *pcmd;
  struct redircmd *rcmd;

  if(cmd == 0)
     9aa:	85 db                	test   %ebx,%ebx
     9ac:	74 20                	je     9ce <nulterminate+0x2e>
    return 0;

  switch(cmd->type){
     9ae:	83 3b 05             	cmpl   $0x5,(%ebx)
     9b1:	77 1b                	ja     9ce <nulterminate+0x2e>
     9b3:	8b 03                	mov    (%ebx),%eax
     9b5:	ff 24 85 88 16 00 00 	jmp    *0x1688(,%eax,4)
     9bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    nulterminate(lcmd->right);
    break;

  case BACK:
    bcmd = (struct backcmd*)cmd;
    nulterminate(bcmd->cmd);
     9c0:	83 ec 0c             	sub    $0xc,%esp
     9c3:	ff 73 04             	pushl  0x4(%ebx)
     9c6:	e8 d5 ff ff ff       	call   9a0 <nulterminate>
    break;
     9cb:	83 c4 10             	add    $0x10,%esp
  }
  return cmd;
}
     9ce:	89 d8                	mov    %ebx,%eax
     9d0:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9d3:	c9                   	leave  
     9d4:	c3                   	ret    
     9d5:	8d 76 00             	lea    0x0(%esi),%esi
    nulterminate(lcmd->left);
     9d8:	83 ec 0c             	sub    $0xc,%esp
     9db:	ff 73 04             	pushl  0x4(%ebx)
     9de:	e8 bd ff ff ff       	call   9a0 <nulterminate>
    nulterminate(lcmd->right);
     9e3:	58                   	pop    %eax
     9e4:	ff 73 08             	pushl  0x8(%ebx)
     9e7:	e8 b4 ff ff ff       	call   9a0 <nulterminate>
}
     9ec:	89 d8                	mov    %ebx,%eax
    break;
     9ee:	83 c4 10             	add    $0x10,%esp
}
     9f1:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     9f4:	c9                   	leave  
     9f5:	c3                   	ret    
     9f6:	8d 76 00             	lea    0x0(%esi),%esi
     9f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    for(i=0; ecmd->argv[i]; i++)
     a00:	8b 4b 04             	mov    0x4(%ebx),%ecx
     a03:	8d 43 08             	lea    0x8(%ebx),%eax
     a06:	85 c9                	test   %ecx,%ecx
     a08:	74 c4                	je     9ce <nulterminate+0x2e>
     a0a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      *ecmd->eargv[i] = 0;
     a10:	8b 50 24             	mov    0x24(%eax),%edx
     a13:	83 c0 04             	add    $0x4,%eax
     a16:	c6 02 00             	movb   $0x0,(%edx)
    for(i=0; ecmd->argv[i]; i++)
     a19:	8b 50 fc             	mov    -0x4(%eax),%edx
     a1c:	85 d2                	test   %edx,%edx
     a1e:	75 f0                	jne    a10 <nulterminate+0x70>
}
     a20:	89 d8                	mov    %ebx,%eax
     a22:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a25:	c9                   	leave  
     a26:	c3                   	ret    
     a27:	89 f6                	mov    %esi,%esi
     a29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    nulterminate(rcmd->cmd);
     a30:	83 ec 0c             	sub    $0xc,%esp
     a33:	ff 73 04             	pushl  0x4(%ebx)
     a36:	e8 65 ff ff ff       	call   9a0 <nulterminate>
    *rcmd->efile = 0;
     a3b:	8b 43 0c             	mov    0xc(%ebx),%eax
    break;
     a3e:	83 c4 10             	add    $0x10,%esp
    *rcmd->efile = 0;
     a41:	c6 00 00             	movb   $0x0,(%eax)
}
     a44:	89 d8                	mov    %ebx,%eax
     a46:	8b 5d fc             	mov    -0x4(%ebp),%ebx
     a49:	c9                   	leave  
     a4a:	c3                   	ret    
     a4b:	90                   	nop
     a4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a50 <parsecmd>:
{
     a50:	55                   	push   %ebp
     a51:	89 e5                	mov    %esp,%ebp
     a53:	56                   	push   %esi
     a54:	53                   	push   %ebx
  es = s + strlen(s);
     a55:	8b 5d 08             	mov    0x8(%ebp),%ebx
     a58:	83 ec 0c             	sub    $0xc,%esp
     a5b:	53                   	push   %ebx
     a5c:	e8 df 00 00 00       	call   b40 <strlen>
  cmd = parseline(&s, es);
     a61:	59                   	pop    %ecx
  es = s + strlen(s);
     a62:	01 c3                	add    %eax,%ebx
  cmd = parseline(&s, es);
     a64:	8d 45 08             	lea    0x8(%ebp),%eax
     a67:	5e                   	pop    %esi
     a68:	53                   	push   %ebx
     a69:	50                   	push   %eax
     a6a:	e8 01 fe ff ff       	call   870 <parseline>
     a6f:	89 c6                	mov    %eax,%esi
  peek(&s, es, "");
     a71:	8d 45 08             	lea    0x8(%ebp),%eax
     a74:	83 c4 0c             	add    $0xc,%esp
     a77:	68 ab 16 00 00       	push   $0x16ab
     a7c:	53                   	push   %ebx
     a7d:	50                   	push   %eax
     a7e:	e8 4d fb ff ff       	call   5d0 <peek>
  if(s != es){
     a83:	8b 45 08             	mov    0x8(%ebp),%eax
     a86:	83 c4 10             	add    $0x10,%esp
     a89:	39 d8                	cmp    %ebx,%eax
     a8b:	75 12                	jne    a9f <parsecmd+0x4f>
  nulterminate(cmd);
     a8d:	83 ec 0c             	sub    $0xc,%esp
     a90:	56                   	push   %esi
     a91:	e8 0a ff ff ff       	call   9a0 <nulterminate>
}
     a96:	8d 65 f8             	lea    -0x8(%ebp),%esp
     a99:	89 f0                	mov    %esi,%eax
     a9b:	5b                   	pop    %ebx
     a9c:	5e                   	pop    %esi
     a9d:	5d                   	pop    %ebp
     a9e:	c3                   	ret    
    printf(2, "leftovers: %s\n", s);
     a9f:	52                   	push   %edx
     aa0:	50                   	push   %eax
     aa1:	68 4a 16 00 00       	push   $0x164a
     aa6:	6a 02                	push   $0x2
     aa8:	e8 b3 07 00 00       	call   1260 <printf>
    panic("syntax");
     aad:	c7 04 24 0e 16 00 00 	movl   $0x160e,(%esp)
     ab4:	e8 97 f6 ff ff       	call   150 <panic>
     ab9:	66 90                	xchg   %ax,%ax
     abb:	66 90                	xchg   %ax,%ax
     abd:	66 90                	xchg   %ax,%ax
     abf:	90                   	nop

00000ac0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
     ac0:	55                   	push   %ebp
     ac1:	89 e5                	mov    %esp,%ebp
     ac3:	53                   	push   %ebx
     ac4:	8b 45 08             	mov    0x8(%ebp),%eax
     ac7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
     aca:	89 c2                	mov    %eax,%edx
     acc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     ad0:	83 c1 01             	add    $0x1,%ecx
     ad3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
     ad7:	83 c2 01             	add    $0x1,%edx
     ada:	84 db                	test   %bl,%bl
     adc:	88 5a ff             	mov    %bl,-0x1(%edx)
     adf:	75 ef                	jne    ad0 <strcpy+0x10>
    ;
  return os;
}
     ae1:	5b                   	pop    %ebx
     ae2:	5d                   	pop    %ebp
     ae3:	c3                   	ret    
     ae4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     aea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000af0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
     af0:	55                   	push   %ebp
     af1:	89 e5                	mov    %esp,%ebp
     af3:	53                   	push   %ebx
     af4:	8b 55 08             	mov    0x8(%ebp),%edx
     af7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
     afa:	0f b6 02             	movzbl (%edx),%eax
     afd:	0f b6 19             	movzbl (%ecx),%ebx
     b00:	84 c0                	test   %al,%al
     b02:	75 1c                	jne    b20 <strcmp+0x30>
     b04:	eb 2a                	jmp    b30 <strcmp+0x40>
     b06:	8d 76 00             	lea    0x0(%esi),%esi
     b09:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
     b10:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
     b13:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
     b16:	83 c1 01             	add    $0x1,%ecx
     b19:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
     b1c:	84 c0                	test   %al,%al
     b1e:	74 10                	je     b30 <strcmp+0x40>
     b20:	38 d8                	cmp    %bl,%al
     b22:	74 ec                	je     b10 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
     b24:	29 d8                	sub    %ebx,%eax
}
     b26:	5b                   	pop    %ebx
     b27:	5d                   	pop    %ebp
     b28:	c3                   	ret    
     b29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     b30:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
     b32:	29 d8                	sub    %ebx,%eax
}
     b34:	5b                   	pop    %ebx
     b35:	5d                   	pop    %ebp
     b36:	c3                   	ret    
     b37:	89 f6                	mov    %esi,%esi
     b39:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b40 <strlen>:

uint
strlen(const char *s)
{
     b40:	55                   	push   %ebp
     b41:	89 e5                	mov    %esp,%ebp
     b43:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
     b46:	80 39 00             	cmpb   $0x0,(%ecx)
     b49:	74 15                	je     b60 <strlen+0x20>
     b4b:	31 d2                	xor    %edx,%edx
     b4d:	8d 76 00             	lea    0x0(%esi),%esi
     b50:	83 c2 01             	add    $0x1,%edx
     b53:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
     b57:	89 d0                	mov    %edx,%eax
     b59:	75 f5                	jne    b50 <strlen+0x10>
    ;
  return n;
}
     b5b:	5d                   	pop    %ebp
     b5c:	c3                   	ret    
     b5d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
     b60:	31 c0                	xor    %eax,%eax
}
     b62:	5d                   	pop    %ebp
     b63:	c3                   	ret    
     b64:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     b6a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000b70 <memset>:

void*
memset(void *dst, int c, uint n)
{
     b70:	55                   	push   %ebp
     b71:	89 e5                	mov    %esp,%ebp
     b73:	57                   	push   %edi
     b74:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
     b77:	8b 4d 10             	mov    0x10(%ebp),%ecx
     b7a:	8b 45 0c             	mov    0xc(%ebp),%eax
     b7d:	89 d7                	mov    %edx,%edi
     b7f:	fc                   	cld    
     b80:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
     b82:	89 d0                	mov    %edx,%eax
     b84:	5f                   	pop    %edi
     b85:	5d                   	pop    %ebp
     b86:	c3                   	ret    
     b87:	89 f6                	mov    %esi,%esi
     b89:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000b90 <strchr>:

char*
strchr(const char *s, char c)
{
     b90:	55                   	push   %ebp
     b91:	89 e5                	mov    %esp,%ebp
     b93:	53                   	push   %ebx
     b94:	8b 45 08             	mov    0x8(%ebp),%eax
     b97:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
     b9a:	0f b6 10             	movzbl (%eax),%edx
     b9d:	84 d2                	test   %dl,%dl
     b9f:	74 1d                	je     bbe <strchr+0x2e>
    if(*s == c)
     ba1:	38 d3                	cmp    %dl,%bl
     ba3:	89 d9                	mov    %ebx,%ecx
     ba5:	75 0d                	jne    bb4 <strchr+0x24>
     ba7:	eb 17                	jmp    bc0 <strchr+0x30>
     ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
     bb0:	38 ca                	cmp    %cl,%dl
     bb2:	74 0c                	je     bc0 <strchr+0x30>
  for(; *s; s++)
     bb4:	83 c0 01             	add    $0x1,%eax
     bb7:	0f b6 10             	movzbl (%eax),%edx
     bba:	84 d2                	test   %dl,%dl
     bbc:	75 f2                	jne    bb0 <strchr+0x20>
      return (char*)s;
  return 0;
     bbe:	31 c0                	xor    %eax,%eax
}
     bc0:	5b                   	pop    %ebx
     bc1:	5d                   	pop    %ebp
     bc2:	c3                   	ret    
     bc3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     bc9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000bd0 <gets>:

char*
gets(char *buf, int max)
{
     bd0:	55                   	push   %ebp
     bd1:	89 e5                	mov    %esp,%ebp
     bd3:	57                   	push   %edi
     bd4:	56                   	push   %esi
     bd5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
     bd6:	31 f6                	xor    %esi,%esi
     bd8:	89 f3                	mov    %esi,%ebx
{
     bda:	83 ec 1c             	sub    $0x1c,%esp
     bdd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
     be0:	eb 2f                	jmp    c11 <gets+0x41>
     be2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
     be8:	8d 45 e7             	lea    -0x19(%ebp),%eax
     beb:	83 ec 04             	sub    $0x4,%esp
     bee:	6a 01                	push   $0x1
     bf0:	50                   	push   %eax
     bf1:	6a 00                	push   $0x0
     bf3:	e8 e6 04 00 00       	call   10de <read>
    if(cc < 1)
     bf8:	83 c4 10             	add    $0x10,%esp
     bfb:	85 c0                	test   %eax,%eax
     bfd:	7e 1c                	jle    c1b <gets+0x4b>
      break;
    buf[i++] = c;
     bff:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
     c03:	83 c7 01             	add    $0x1,%edi
     c06:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
     c09:	3c 0a                	cmp    $0xa,%al
     c0b:	74 23                	je     c30 <gets+0x60>
     c0d:	3c 0d                	cmp    $0xd,%al
     c0f:	74 1f                	je     c30 <gets+0x60>
  for(i=0; i+1 < max; ){
     c11:	83 c3 01             	add    $0x1,%ebx
     c14:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
     c17:	89 fe                	mov    %edi,%esi
     c19:	7c cd                	jl     be8 <gets+0x18>
     c1b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
     c1d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
     c20:	c6 03 00             	movb   $0x0,(%ebx)
}
     c23:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c26:	5b                   	pop    %ebx
     c27:	5e                   	pop    %esi
     c28:	5f                   	pop    %edi
     c29:	5d                   	pop    %ebp
     c2a:	c3                   	ret    
     c2b:	90                   	nop
     c2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c30:	8b 75 08             	mov    0x8(%ebp),%esi
     c33:	8b 45 08             	mov    0x8(%ebp),%eax
     c36:	01 de                	add    %ebx,%esi
     c38:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
     c3a:	c6 03 00             	movb   $0x0,(%ebx)
}
     c3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     c40:	5b                   	pop    %ebx
     c41:	5e                   	pop    %esi
     c42:	5f                   	pop    %edi
     c43:	5d                   	pop    %ebp
     c44:	c3                   	ret    
     c45:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     c49:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000c50 <stat>:

int
stat(const char *n, struct stat *st)
{
     c50:	55                   	push   %ebp
     c51:	89 e5                	mov    %esp,%ebp
     c53:	56                   	push   %esi
     c54:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
     c55:	83 ec 08             	sub    $0x8,%esp
     c58:	6a 00                	push   $0x0
     c5a:	ff 75 08             	pushl  0x8(%ebp)
     c5d:	e8 a4 04 00 00       	call   1106 <open>
  if(fd < 0)
     c62:	83 c4 10             	add    $0x10,%esp
     c65:	85 c0                	test   %eax,%eax
     c67:	78 27                	js     c90 <stat+0x40>
    return -1;
  r = fstat(fd, st);
     c69:	83 ec 08             	sub    $0x8,%esp
     c6c:	ff 75 0c             	pushl  0xc(%ebp)
     c6f:	89 c3                	mov    %eax,%ebx
     c71:	50                   	push   %eax
     c72:	e8 a7 04 00 00       	call   111e <fstat>
  close(fd);
     c77:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
     c7a:	89 c6                	mov    %eax,%esi
  close(fd);
     c7c:	e8 6d 04 00 00       	call   10ee <close>
  return r;
     c81:	83 c4 10             	add    $0x10,%esp
}
     c84:	8d 65 f8             	lea    -0x8(%ebp),%esp
     c87:	89 f0                	mov    %esi,%eax
     c89:	5b                   	pop    %ebx
     c8a:	5e                   	pop    %esi
     c8b:	5d                   	pop    %ebp
     c8c:	c3                   	ret    
     c8d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
     c90:	be ff ff ff ff       	mov    $0xffffffff,%esi
     c95:	eb ed                	jmp    c84 <stat+0x34>
     c97:	89 f6                	mov    %esi,%esi
     c99:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000ca0 <atoi>:

int
atoi(const char *s)
{
     ca0:	55                   	push   %ebp
     ca1:	89 e5                	mov    %esp,%ebp
     ca3:	53                   	push   %ebx
     ca4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
     ca7:	0f be 11             	movsbl (%ecx),%edx
     caa:	8d 42 d0             	lea    -0x30(%edx),%eax
     cad:	3c 09                	cmp    $0x9,%al
  n = 0;
     caf:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
     cb4:	77 1f                	ja     cd5 <atoi+0x35>
     cb6:	8d 76 00             	lea    0x0(%esi),%esi
     cb9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
     cc0:	8d 04 80             	lea    (%eax,%eax,4),%eax
     cc3:	83 c1 01             	add    $0x1,%ecx
     cc6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
     cca:	0f be 11             	movsbl (%ecx),%edx
     ccd:	8d 5a d0             	lea    -0x30(%edx),%ebx
     cd0:	80 fb 09             	cmp    $0x9,%bl
     cd3:	76 eb                	jbe    cc0 <atoi+0x20>
  return n;
}
     cd5:	5b                   	pop    %ebx
     cd6:	5d                   	pop    %ebp
     cd7:	c3                   	ret    
     cd8:	90                   	nop
     cd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000ce0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
     ce0:	55                   	push   %ebp
     ce1:	89 e5                	mov    %esp,%ebp
     ce3:	56                   	push   %esi
     ce4:	53                   	push   %ebx
     ce5:	8b 5d 10             	mov    0x10(%ebp),%ebx
     ce8:	8b 45 08             	mov    0x8(%ebp),%eax
     ceb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
     cee:	85 db                	test   %ebx,%ebx
     cf0:	7e 14                	jle    d06 <memmove+0x26>
     cf2:	31 d2                	xor    %edx,%edx
     cf4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
     cf8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
     cfc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
     cff:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
     d02:	39 d3                	cmp    %edx,%ebx
     d04:	75 f2                	jne    cf8 <memmove+0x18>
  return vdst;
}
     d06:	5b                   	pop    %ebx
     d07:	5e                   	pop    %esi
     d08:	5d                   	pop    %ebp
     d09:	c3                   	ret    
     d0a:	66 90                	xchg   %ax,%ax
     d0c:	66 90                	xchg   %ax,%ax
     d0e:	66 90                	xchg   %ax,%ax

00000d10 <mystrcmp>:
#include "ls.h"
// #include "defs.h"

int
mystrcmp (char *s1, char *s2)
{
     d10:	55                   	push   %ebp
     d11:	89 e5                	mov    %esp,%ebp
     d13:	56                   	push   %esi
     d14:	53                   	push   %ebx
     d15:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int a =0,b=0;
     d18:	31 db                	xor    %ebx,%ebx
{
     d1a:	8b 55 0c             	mov    0xc(%ebp),%edx
    while(*s1){a++;s1++;}
     d1d:	80 39 00             	cmpb   $0x0,(%ecx)
     d20:	0f b6 02             	movzbl (%edx),%eax
     d23:	74 33                	je     d58 <mystrcmp+0x48>
     d25:	8d 76 00             	lea    0x0(%esi),%esi
     d28:	83 c1 01             	add    $0x1,%ecx
     d2b:	83 c3 01             	add    $0x1,%ebx
     d2e:	80 39 00             	cmpb   $0x0,(%ecx)
     d31:	75 f5                	jne    d28 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
     d33:	84 c0                	test   %al,%al
     d35:	74 51                	je     d88 <mystrcmp+0x78>
    int a =0,b=0;
     d37:	31 f6                	xor    %esi,%esi
     d39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
     d40:	83 c2 01             	add    $0x1,%edx
     d43:	83 c6 01             	add    $0x1,%esi
     d46:	80 3a 00             	cmpb   $0x0,(%edx)
     d49:	75 f5                	jne    d40 <mystrcmp+0x30>

    if(a!=b)return 0;
     d4b:	31 c0                	xor    %eax,%eax
     d4d:	39 de                	cmp    %ebx,%esi
     d4f:	74 0f                	je     d60 <mystrcmp+0x50>
    // printf("here");
    while(a--){
        if(*s1++ != *s2++)return 0;
    }
    return 1;
}
     d51:	5b                   	pop    %ebx
     d52:	5e                   	pop    %esi
     d53:	5d                   	pop    %ebp
     d54:	c3                   	ret    
     d55:	8d 76 00             	lea    0x0(%esi),%esi
    while(*s2){b++;s2++;}
     d58:	84 c0                	test   %al,%al
     d5a:	75 db                	jne    d37 <mystrcmp+0x27>
     d5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d60:	01 d3                	add    %edx,%ebx
     d62:	eb 13                	jmp    d77 <mystrcmp+0x67>
     d64:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(*s1++ != *s2++)return 0;
     d68:	83 c2 01             	add    $0x1,%edx
     d6b:	83 c1 01             	add    $0x1,%ecx
     d6e:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
     d72:	38 41 ff             	cmp    %al,-0x1(%ecx)
     d75:	75 11                	jne    d88 <mystrcmp+0x78>
    while(a--){
     d77:	39 d3                	cmp    %edx,%ebx
     d79:	75 ed                	jne    d68 <mystrcmp+0x58>
}
     d7b:	5b                   	pop    %ebx
    return 1;
     d7c:	b8 01 00 00 00       	mov    $0x1,%eax
}
     d81:	5e                   	pop    %esi
     d82:	5d                   	pop    %ebp
     d83:	c3                   	ret    
     d84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
     d88:	5b                   	pop    %ebx
    if(a!=b)return 0;
     d89:	31 c0                	xor    %eax,%eax
}
     d8b:	5e                   	pop    %esi
     d8c:	5d                   	pop    %ebp
     d8d:	c3                   	ret    
     d8e:	66 90                	xchg   %ax,%ax

00000d90 <fmtname>:

char*
fmtname(char *path)
{
     d90:	55                   	push   %ebp
     d91:	89 e5                	mov    %esp,%ebp
     d93:	56                   	push   %esi
     d94:	53                   	push   %ebx
     d95:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
     d98:	83 ec 0c             	sub    $0xc,%esp
     d9b:	53                   	push   %ebx
     d9c:	e8 9f fd ff ff       	call   b40 <strlen>
     da1:	83 c4 10             	add    $0x10,%esp
     da4:	01 d8                	add    %ebx,%eax
     da6:	73 0f                	jae    db7 <fmtname+0x27>
     da8:	eb 12                	jmp    dbc <fmtname+0x2c>
     daa:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     db0:	83 e8 01             	sub    $0x1,%eax
     db3:	39 c3                	cmp    %eax,%ebx
     db5:	77 05                	ja     dbc <fmtname+0x2c>
     db7:	80 38 2f             	cmpb   $0x2f,(%eax)
     dba:	75 f4                	jne    db0 <fmtname+0x20>
    ;
  p++;
     dbc:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
     dbf:	83 ec 0c             	sub    $0xc,%esp
     dc2:	53                   	push   %ebx
     dc3:	e8 78 fd ff ff       	call   b40 <strlen>
     dc8:	83 c4 10             	add    $0x10,%esp
     dcb:	83 f8 0d             	cmp    $0xd,%eax
     dce:	77 4a                	ja     e1a <fmtname+0x8a>
    return p;
  memmove(buf, p, strlen(p));
     dd0:	83 ec 0c             	sub    $0xc,%esp
     dd3:	53                   	push   %ebx
     dd4:	e8 67 fd ff ff       	call   b40 <strlen>
     dd9:	83 c4 0c             	add    $0xc,%esp
     ddc:	50                   	push   %eax
     ddd:	53                   	push   %ebx
     dde:	68 e4 1d 00 00       	push   $0x1de4
     de3:	e8 f8 fe ff ff       	call   ce0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
     de8:	89 1c 24             	mov    %ebx,(%esp)
     deb:	e8 50 fd ff ff       	call   b40 <strlen>
     df0:	89 1c 24             	mov    %ebx,(%esp)
     df3:	89 c6                	mov    %eax,%esi
  return buf;
     df5:	bb e4 1d 00 00       	mov    $0x1de4,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
     dfa:	e8 41 fd ff ff       	call   b40 <strlen>
     dff:	ba 0e 00 00 00       	mov    $0xe,%edx
     e04:	83 c4 0c             	add    $0xc,%esp
     e07:	05 e4 1d 00 00       	add    $0x1de4,%eax
     e0c:	29 f2                	sub    %esi,%edx
     e0e:	52                   	push   %edx
     e0f:	6a 20                	push   $0x20
     e11:	50                   	push   %eax
     e12:	e8 59 fd ff ff       	call   b70 <memset>
  return buf;
     e17:	83 c4 10             	add    $0x10,%esp
}
     e1a:	8d 65 f8             	lea    -0x8(%ebp),%esp
     e1d:	89 d8                	mov    %ebx,%eax
     e1f:	5b                   	pop    %ebx
     e20:	5e                   	pop    %esi
     e21:	5d                   	pop    %ebp
     e22:	c3                   	ret    
     e23:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
     e29:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000e30 <ls>:

void
ls(char *path)
{
     e30:	55                   	push   %ebp
     e31:	89 e5                	mov    %esp,%ebp
     e33:	57                   	push   %edi
     e34:	56                   	push   %esi
     e35:	53                   	push   %ebx
     e36:	81 ec 5c 02 00 00    	sub    $0x25c,%esp

  int cid = getcid();
     e3c:	e8 6d 03 00 00       	call   11ae <getcid>

  printf(2, "Cid is: %d\n", cid);
     e41:	83 ec 04             	sub    $0x4,%esp
  int cid = getcid();
     e44:	89 c7                	mov    %eax,%edi
  printf(2, "Cid is: %d\n", cid);
     e46:	50                   	push   %eax
     e47:	68 a0 16 00 00       	push   $0x16a0
     e4c:	6a 02                	push   $0x2
     e4e:	e8 0d 04 00 00       	call   1260 <printf>
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  if((fd = open(path, 0)) < 0){
     e53:	59                   	pop    %ecx
     e54:	5b                   	pop    %ebx
     e55:	6a 00                	push   $0x0
     e57:	ff 75 08             	pushl  0x8(%ebp)
     e5a:	e8 a7 02 00 00       	call   1106 <open>
     e5f:	83 c4 10             	add    $0x10,%esp
     e62:	85 c0                	test   %eax,%eax
     e64:	78 5a                	js     ec0 <ls+0x90>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
     e66:	8d b5 d0 fd ff ff    	lea    -0x230(%ebp),%esi
     e6c:	83 ec 08             	sub    $0x8,%esp
     e6f:	89 c3                	mov    %eax,%ebx
     e71:	56                   	push   %esi
     e72:	50                   	push   %eax
     e73:	e8 a6 02 00 00       	call   111e <fstat>
     e78:	83 c4 10             	add    $0x10,%esp
     e7b:	85 c0                	test   %eax,%eax
     e7d:	0f 88 cd 00 00 00    	js     f50 <ls+0x120>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  switch(st.type){
     e83:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
     e8a:	66 83 f8 01          	cmp    $0x1,%ax
     e8e:	74 50                	je     ee0 <ls+0xb0>
     e90:	66 83 f8 02          	cmp    $0x2,%ax
     e94:	75 12                	jne    ea8 <ls+0x78>
  case T_FILE:
    if (st.cid ==0 || st.cid==-1 || st.cid == cid){
     e96:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
     e9c:	8d 42 01             	lea    0x1(%edx),%eax
     e9f:	83 f8 01             	cmp    $0x1,%eax
     ea2:	76 6c                	jbe    f10 <ls+0xe0>
     ea4:	39 fa                	cmp    %edi,%edx
     ea6:	74 68                	je     f10 <ls+0xe0>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
    }
    break;
  }
  close(fd);
     ea8:	83 ec 0c             	sub    $0xc,%esp
     eab:	53                   	push   %ebx
     eac:	e8 3d 02 00 00       	call   10ee <close>
     eb1:	83 c4 10             	add    $0x10,%esp

}
     eb4:	8d 65 f4             	lea    -0xc(%ebp),%esp
     eb7:	5b                   	pop    %ebx
     eb8:	5e                   	pop    %esi
     eb9:	5f                   	pop    %edi
     eba:	5d                   	pop    %ebp
     ebb:	c3                   	ret    
     ebc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
     ec0:	83 ec 04             	sub    $0x4,%esp
     ec3:	ff 75 08             	pushl  0x8(%ebp)
     ec6:	68 ac 16 00 00       	push   $0x16ac
     ecb:	6a 02                	push   $0x2
     ecd:	e8 8e 03 00 00       	call   1260 <printf>
    return;
     ed2:	83 c4 10             	add    $0x10,%esp
}
     ed5:	8d 65 f4             	lea    -0xc(%ebp),%esp
     ed8:	5b                   	pop    %ebx
     ed9:	5e                   	pop    %esi
     eda:	5f                   	pop    %edi
     edb:	5d                   	pop    %ebp
     edc:	c3                   	ret    
     edd:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
     ee0:	83 ec 0c             	sub    $0xc,%esp
     ee3:	ff 75 08             	pushl  0x8(%ebp)
     ee6:	e8 55 fc ff ff       	call   b40 <strlen>
     eeb:	83 c0 10             	add    $0x10,%eax
     eee:	83 c4 10             	add    $0x10,%esp
     ef1:	3d 00 02 00 00       	cmp    $0x200,%eax
     ef6:	0f 86 7c 00 00 00    	jbe    f78 <ls+0x148>
      printf(1, "ls: path too long\n");
     efc:	83 ec 08             	sub    $0x8,%esp
     eff:	68 e4 16 00 00       	push   $0x16e4
     f04:	6a 01                	push   $0x1
     f06:	e8 55 03 00 00       	call   1260 <printf>
      break;
     f0b:	83 c4 10             	add    $0x10,%esp
     f0e:	eb 98                	jmp    ea8 <ls+0x78>
    printf(1, "%s %d %d %d %d\n", fmtname(path), st.type, st.ino, st.size, st.cid);
     f10:	83 ec 0c             	sub    $0xc,%esp
     f13:	ff 75 08             	pushl  0x8(%ebp)
     f16:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
     f1c:	8b bd e0 fd ff ff    	mov    -0x220(%ebp),%edi
     f22:	8b b5 d8 fd ff ff    	mov    -0x228(%ebp),%esi
     f28:	e8 63 fe ff ff       	call   d90 <fmtname>
     f2d:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
     f33:	83 c4 0c             	add    $0xc,%esp
     f36:	52                   	push   %edx
     f37:	57                   	push   %edi
     f38:	56                   	push   %esi
     f39:	6a 02                	push   $0x2
     f3b:	50                   	push   %eax
     f3c:	68 d4 16 00 00       	push   $0x16d4
     f41:	6a 01                	push   $0x1
     f43:	e8 18 03 00 00       	call   1260 <printf>
    break;
     f48:	83 c4 20             	add    $0x20,%esp
     f4b:	e9 58 ff ff ff       	jmp    ea8 <ls+0x78>
    printf(2, "ls: cannot stat %s\n", path);
     f50:	83 ec 04             	sub    $0x4,%esp
     f53:	ff 75 08             	pushl  0x8(%ebp)
     f56:	68 c0 16 00 00       	push   $0x16c0
     f5b:	6a 02                	push   $0x2
     f5d:	e8 fe 02 00 00       	call   1260 <printf>
    close(fd);
     f62:	89 1c 24             	mov    %ebx,(%esp)
     f65:	e8 84 01 00 00       	call   10ee <close>
    return;
     f6a:	83 c4 10             	add    $0x10,%esp
}
     f6d:	8d 65 f4             	lea    -0xc(%ebp),%esp
     f70:	5b                   	pop    %ebx
     f71:	5e                   	pop    %esi
     f72:	5f                   	pop    %edi
     f73:	5d                   	pop    %ebp
     f74:	c3                   	ret    
     f75:	8d 76 00             	lea    0x0(%esi),%esi
    strcpy(buf, path);
     f78:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
     f7e:	83 ec 08             	sub    $0x8,%esp
     f81:	ff 75 08             	pushl  0x8(%ebp)
     f84:	50                   	push   %eax
     f85:	e8 36 fb ff ff       	call   ac0 <strcpy>
    p = buf+strlen(buf);
     f8a:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
     f90:	89 04 24             	mov    %eax,(%esp)
     f93:	e8 a8 fb ff ff       	call   b40 <strlen>
     f98:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     f9e:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
     fa1:	01 c8                	add    %ecx,%eax
    *p++ = '/';
     fa3:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
     fa6:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
     fac:	c6 00 2f             	movb   $0x2f,(%eax)
     faf:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
     fb5:	8d 76 00             	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
     fb8:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
     fbe:	83 ec 04             	sub    $0x4,%esp
     fc1:	6a 10                	push   $0x10
     fc3:	50                   	push   %eax
     fc4:	53                   	push   %ebx
     fc5:	e8 14 01 00 00       	call   10de <read>
     fca:	83 c4 10             	add    $0x10,%esp
     fcd:	83 f8 10             	cmp    $0x10,%eax
     fd0:	0f 85 d2 fe ff ff    	jne    ea8 <ls+0x78>
      if(de.inum == 0)
     fd6:	66 83 bd c0 fd ff ff 	cmpw   $0x0,-0x240(%ebp)
     fdd:	00 
     fde:	74 d8                	je     fb8 <ls+0x188>
      memmove(p, de.name, DIRSIZ);
     fe0:	8d 85 c2 fd ff ff    	lea    -0x23e(%ebp),%eax
     fe6:	83 ec 04             	sub    $0x4,%esp
     fe9:	6a 0e                	push   $0xe
     feb:	50                   	push   %eax
     fec:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
     ff2:	e8 e9 fc ff ff       	call   ce0 <memmove>
      p[DIRSIZ] = 0;
     ff7:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
     ffd:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
    1001:	58                   	pop    %eax
    1002:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
    1008:	5a                   	pop    %edx
    1009:	56                   	push   %esi
    100a:	50                   	push   %eax
    100b:	e8 40 fc ff ff       	call   c50 <stat>
    1010:	83 c4 10             	add    $0x10,%esp
    1013:	85 c0                	test   %eax,%eax
    1015:	0f 88 85 00 00 00    	js     10a0 <ls+0x270>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
    101b:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
    1021:	8d 42 01             	lea    0x1(%edx),%eax
    1024:	83 f8 01             	cmp    $0x1,%eax
    1027:	76 04                	jbe    102d <ls+0x1fd>
    1029:	39 fa                	cmp    %edi,%edx
    102b:	75 8b                	jne    fb8 <ls+0x188>
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
    102d:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
    1033:	89 95 a0 fd ff ff    	mov    %edx,-0x260(%ebp)
    1039:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
    103f:	83 ec 0c             	sub    $0xc,%esp
    1042:	8b 85 d8 fd ff ff    	mov    -0x228(%ebp),%eax
    1048:	52                   	push   %edx
    1049:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
    104f:	0f bf 8d d0 fd ff ff 	movswl -0x230(%ebp),%ecx
    1056:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
    105c:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
    1062:	e8 29 fd ff ff       	call   d90 <fmtname>
    1067:	8b 95 a0 fd ff ff    	mov    -0x260(%ebp),%edx
    106d:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
    1073:	83 c4 0c             	add    $0xc,%esp
    1076:	52                   	push   %edx
    1077:	51                   	push   %ecx
    1078:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
    107e:	ff b5 a8 fd ff ff    	pushl  -0x258(%ebp)
    1084:	50                   	push   %eax
    1085:	68 d4 16 00 00       	push   $0x16d4
    108a:	6a 01                	push   $0x1
    108c:	e8 cf 01 00 00       	call   1260 <printf>
    1091:	83 c4 20             	add    $0x20,%esp
    1094:	e9 1f ff ff ff       	jmp    fb8 <ls+0x188>
    1099:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
    10a0:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
    10a6:	83 ec 04             	sub    $0x4,%esp
    10a9:	50                   	push   %eax
    10aa:	68 c0 16 00 00       	push   $0x16c0
    10af:	6a 01                	push   $0x1
    10b1:	e8 aa 01 00 00       	call   1260 <printf>
        continue;
    10b6:	83 c4 10             	add    $0x10,%esp
    10b9:	e9 fa fe ff ff       	jmp    fb8 <ls+0x188>

000010be <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
    10be:	b8 01 00 00 00       	mov    $0x1,%eax
    10c3:	cd 40                	int    $0x40
    10c5:	c3                   	ret    

000010c6 <exit>:
SYSCALL(exit)
    10c6:	b8 02 00 00 00       	mov    $0x2,%eax
    10cb:	cd 40                	int    $0x40
    10cd:	c3                   	ret    

000010ce <wait>:
SYSCALL(wait)
    10ce:	b8 03 00 00 00       	mov    $0x3,%eax
    10d3:	cd 40                	int    $0x40
    10d5:	c3                   	ret    

000010d6 <pipe>:
SYSCALL(pipe)
    10d6:	b8 04 00 00 00       	mov    $0x4,%eax
    10db:	cd 40                	int    $0x40
    10dd:	c3                   	ret    

000010de <read>:
SYSCALL(read)
    10de:	b8 05 00 00 00       	mov    $0x5,%eax
    10e3:	cd 40                	int    $0x40
    10e5:	c3                   	ret    

000010e6 <write>:
SYSCALL(write)
    10e6:	b8 10 00 00 00       	mov    $0x10,%eax
    10eb:	cd 40                	int    $0x40
    10ed:	c3                   	ret    

000010ee <close>:
SYSCALL(close)
    10ee:	b8 15 00 00 00       	mov    $0x15,%eax
    10f3:	cd 40                	int    $0x40
    10f5:	c3                   	ret    

000010f6 <kill>:
SYSCALL(kill)
    10f6:	b8 06 00 00 00       	mov    $0x6,%eax
    10fb:	cd 40                	int    $0x40
    10fd:	c3                   	ret    

000010fe <exec>:
SYSCALL(exec)
    10fe:	b8 07 00 00 00       	mov    $0x7,%eax
    1103:	cd 40                	int    $0x40
    1105:	c3                   	ret    

00001106 <open>:
SYSCALL(open)
    1106:	b8 0f 00 00 00       	mov    $0xf,%eax
    110b:	cd 40                	int    $0x40
    110d:	c3                   	ret    

0000110e <mknod>:
SYSCALL(mknod)
    110e:	b8 11 00 00 00       	mov    $0x11,%eax
    1113:	cd 40                	int    $0x40
    1115:	c3                   	ret    

00001116 <unlink>:
SYSCALL(unlink)
    1116:	b8 12 00 00 00       	mov    $0x12,%eax
    111b:	cd 40                	int    $0x40
    111d:	c3                   	ret    

0000111e <fstat>:
SYSCALL(fstat)
    111e:	b8 08 00 00 00       	mov    $0x8,%eax
    1123:	cd 40                	int    $0x40
    1125:	c3                   	ret    

00001126 <link>:
SYSCALL(link)
    1126:	b8 13 00 00 00       	mov    $0x13,%eax
    112b:	cd 40                	int    $0x40
    112d:	c3                   	ret    

0000112e <mkdir>:
SYSCALL(mkdir)
    112e:	b8 14 00 00 00       	mov    $0x14,%eax
    1133:	cd 40                	int    $0x40
    1135:	c3                   	ret    

00001136 <chdir>:
SYSCALL(chdir)
    1136:	b8 09 00 00 00       	mov    $0x9,%eax
    113b:	cd 40                	int    $0x40
    113d:	c3                   	ret    

0000113e <dup>:
SYSCALL(dup)
    113e:	b8 0a 00 00 00       	mov    $0xa,%eax
    1143:	cd 40                	int    $0x40
    1145:	c3                   	ret    

00001146 <getpid>:
SYSCALL(getpid)
    1146:	b8 0b 00 00 00       	mov    $0xb,%eax
    114b:	cd 40                	int    $0x40
    114d:	c3                   	ret    

0000114e <sbrk>:
SYSCALL(sbrk)
    114e:	b8 0c 00 00 00       	mov    $0xc,%eax
    1153:	cd 40                	int    $0x40
    1155:	c3                   	ret    

00001156 <sleep>:
SYSCALL(sleep)
    1156:	b8 0d 00 00 00       	mov    $0xd,%eax
    115b:	cd 40                	int    $0x40
    115d:	c3                   	ret    

0000115e <uptime>:
SYSCALL(uptime)
    115e:	b8 0e 00 00 00       	mov    $0xe,%eax
    1163:	cd 40                	int    $0x40
    1165:	c3                   	ret    

00001166 <halt>:
SYSCALL(halt)
    1166:	b8 16 00 00 00       	mov    $0x16,%eax
    116b:	cd 40                	int    $0x40
    116d:	c3                   	ret    

0000116e <toggle>:
SYSCALL(toggle)
    116e:	b8 17 00 00 00       	mov    $0x17,%eax
    1173:	cd 40                	int    $0x40
    1175:	c3                   	ret    

00001176 <ps>:
SYSCALL(ps)
    1176:	b8 18 00 00 00       	mov    $0x18,%eax
    117b:	cd 40                	int    $0x40
    117d:	c3                   	ret    

0000117e <create_container>:
SYSCALL(create_container)
    117e:	b8 1c 00 00 00       	mov    $0x1c,%eax
    1183:	cd 40                	int    $0x40
    1185:	c3                   	ret    

00001186 <destroy_container>:
SYSCALL(destroy_container)
    1186:	b8 19 00 00 00       	mov    $0x19,%eax
    118b:	cd 40                	int    $0x40
    118d:	c3                   	ret    

0000118e <join_container>:
SYSCALL(join_container)
    118e:	b8 1a 00 00 00       	mov    $0x1a,%eax
    1193:	cd 40                	int    $0x40
    1195:	c3                   	ret    

00001196 <leave_container>:
SYSCALL(leave_container)
    1196:	b8 1b 00 00 00       	mov    $0x1b,%eax
    119b:	cd 40                	int    $0x40
    119d:	c3                   	ret    

0000119e <send>:
SYSCALL(send)
    119e:	b8 1d 00 00 00       	mov    $0x1d,%eax
    11a3:	cd 40                	int    $0x40
    11a5:	c3                   	ret    

000011a6 <recv>:
SYSCALL(recv)
    11a6:	b8 1e 00 00 00       	mov    $0x1e,%eax
    11ab:	cd 40                	int    $0x40
    11ad:	c3                   	ret    

000011ae <getcid>:
SYSCALL(getcid)
    11ae:	b8 1f 00 00 00       	mov    $0x1f,%eax
    11b3:	cd 40                	int    $0x40
    11b5:	c3                   	ret    
    11b6:	66 90                	xchg   %ax,%ax
    11b8:	66 90                	xchg   %ax,%ax
    11ba:	66 90                	xchg   %ax,%ax
    11bc:	66 90                	xchg   %ax,%ax
    11be:	66 90                	xchg   %ax,%ax

000011c0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
    11c0:	55                   	push   %ebp
    11c1:	89 e5                	mov    %esp,%ebp
    11c3:	57                   	push   %edi
    11c4:	56                   	push   %esi
    11c5:	53                   	push   %ebx
    11c6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
    11c9:	85 d2                	test   %edx,%edx
{
    11cb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
    11ce:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
    11d0:	79 76                	jns    1248 <printint+0x88>
    11d2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
    11d6:	74 70                	je     1248 <printint+0x88>
    x = -xx;
    11d8:	f7 d8                	neg    %eax
    neg = 1;
    11da:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
    11e1:	31 f6                	xor    %esi,%esi
    11e3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
    11e6:	eb 0a                	jmp    11f2 <printint+0x32>
    11e8:	90                   	nop
    11e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
    11f0:	89 fe                	mov    %edi,%esi
    11f2:	31 d2                	xor    %edx,%edx
    11f4:	8d 7e 01             	lea    0x1(%esi),%edi
    11f7:	f7 f1                	div    %ecx
    11f9:	0f b6 92 00 17 00 00 	movzbl 0x1700(%edx),%edx
  }while((x /= base) != 0);
    1200:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
    1202:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
    1205:	75 e9                	jne    11f0 <printint+0x30>
  if(neg)
    1207:	8b 45 c4             	mov    -0x3c(%ebp),%eax
    120a:	85 c0                	test   %eax,%eax
    120c:	74 08                	je     1216 <printint+0x56>
    buf[i++] = '-';
    120e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
    1213:	8d 7e 02             	lea    0x2(%esi),%edi
    1216:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
    121a:	8b 7d c0             	mov    -0x40(%ebp),%edi
    121d:	8d 76 00             	lea    0x0(%esi),%esi
    1220:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
    1223:	83 ec 04             	sub    $0x4,%esp
    1226:	83 ee 01             	sub    $0x1,%esi
    1229:	6a 01                	push   $0x1
    122b:	53                   	push   %ebx
    122c:	57                   	push   %edi
    122d:	88 45 d7             	mov    %al,-0x29(%ebp)
    1230:	e8 b1 fe ff ff       	call   10e6 <write>

  while(--i >= 0)
    1235:	83 c4 10             	add    $0x10,%esp
    1238:	39 de                	cmp    %ebx,%esi
    123a:	75 e4                	jne    1220 <printint+0x60>
    putc(fd, buf[i]);
}
    123c:	8d 65 f4             	lea    -0xc(%ebp),%esp
    123f:	5b                   	pop    %ebx
    1240:	5e                   	pop    %esi
    1241:	5f                   	pop    %edi
    1242:	5d                   	pop    %ebp
    1243:	c3                   	ret    
    1244:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
    1248:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
    124f:	eb 90                	jmp    11e1 <printint+0x21>
    1251:	eb 0d                	jmp    1260 <printf>
    1253:	90                   	nop
    1254:	90                   	nop
    1255:	90                   	nop
    1256:	90                   	nop
    1257:	90                   	nop
    1258:	90                   	nop
    1259:	90                   	nop
    125a:	90                   	nop
    125b:	90                   	nop
    125c:	90                   	nop
    125d:	90                   	nop
    125e:	90                   	nop
    125f:	90                   	nop

00001260 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
    1260:	55                   	push   %ebp
    1261:	89 e5                	mov    %esp,%ebp
    1263:	57                   	push   %edi
    1264:	56                   	push   %esi
    1265:	53                   	push   %ebx
    1266:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
    1269:	8b 75 0c             	mov    0xc(%ebp),%esi
    126c:	0f b6 1e             	movzbl (%esi),%ebx
    126f:	84 db                	test   %bl,%bl
    1271:	0f 84 b3 00 00 00    	je     132a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
    1277:	8d 45 10             	lea    0x10(%ebp),%eax
    127a:	83 c6 01             	add    $0x1,%esi
  state = 0;
    127d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
    127f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    1282:	eb 2f                	jmp    12b3 <printf+0x53>
    1284:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
    1288:	83 f8 25             	cmp    $0x25,%eax
    128b:	0f 84 a7 00 00 00    	je     1338 <printf+0xd8>
  write(fd, &c, 1);
    1291:	8d 45 e2             	lea    -0x1e(%ebp),%eax
    1294:	83 ec 04             	sub    $0x4,%esp
    1297:	88 5d e2             	mov    %bl,-0x1e(%ebp)
    129a:	6a 01                	push   $0x1
    129c:	50                   	push   %eax
    129d:	ff 75 08             	pushl  0x8(%ebp)
    12a0:	e8 41 fe ff ff       	call   10e6 <write>
    12a5:	83 c4 10             	add    $0x10,%esp
    12a8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
    12ab:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
    12af:	84 db                	test   %bl,%bl
    12b1:	74 77                	je     132a <printf+0xca>
    if(state == 0){
    12b3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
    12b5:	0f be cb             	movsbl %bl,%ecx
    12b8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
    12bb:	74 cb                	je     1288 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
    12bd:	83 ff 25             	cmp    $0x25,%edi
    12c0:	75 e6                	jne    12a8 <printf+0x48>
      if(c == 'd'){
    12c2:	83 f8 64             	cmp    $0x64,%eax
    12c5:	0f 84 05 01 00 00    	je     13d0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
    12cb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
    12d1:	83 f9 70             	cmp    $0x70,%ecx
    12d4:	74 72                	je     1348 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
    12d6:	83 f8 73             	cmp    $0x73,%eax
    12d9:	0f 84 99 00 00 00    	je     1378 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
    12df:	83 f8 63             	cmp    $0x63,%eax
    12e2:	0f 84 08 01 00 00    	je     13f0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
    12e8:	83 f8 25             	cmp    $0x25,%eax
    12eb:	0f 84 ef 00 00 00    	je     13e0 <printf+0x180>
  write(fd, &c, 1);
    12f1:	8d 45 e7             	lea    -0x19(%ebp),%eax
    12f4:	83 ec 04             	sub    $0x4,%esp
    12f7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
    12fb:	6a 01                	push   $0x1
    12fd:	50                   	push   %eax
    12fe:	ff 75 08             	pushl  0x8(%ebp)
    1301:	e8 e0 fd ff ff       	call   10e6 <write>
    1306:	83 c4 0c             	add    $0xc,%esp
    1309:	8d 45 e6             	lea    -0x1a(%ebp),%eax
    130c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
    130f:	6a 01                	push   $0x1
    1311:	50                   	push   %eax
    1312:	ff 75 08             	pushl  0x8(%ebp)
    1315:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
    1318:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
    131a:	e8 c7 fd ff ff       	call   10e6 <write>
  for(i = 0; fmt[i]; i++){
    131f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
    1323:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
    1326:	84 db                	test   %bl,%bl
    1328:	75 89                	jne    12b3 <printf+0x53>
    }
  }
}
    132a:	8d 65 f4             	lea    -0xc(%ebp),%esp
    132d:	5b                   	pop    %ebx
    132e:	5e                   	pop    %esi
    132f:	5f                   	pop    %edi
    1330:	5d                   	pop    %ebp
    1331:	c3                   	ret    
    1332:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
    1338:	bf 25 00 00 00       	mov    $0x25,%edi
    133d:	e9 66 ff ff ff       	jmp    12a8 <printf+0x48>
    1342:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
    1348:	83 ec 0c             	sub    $0xc,%esp
    134b:	b9 10 00 00 00       	mov    $0x10,%ecx
    1350:	6a 00                	push   $0x0
    1352:	8b 7d d4             	mov    -0x2c(%ebp),%edi
    1355:	8b 45 08             	mov    0x8(%ebp),%eax
    1358:	8b 17                	mov    (%edi),%edx
    135a:	e8 61 fe ff ff       	call   11c0 <printint>
        ap++;
    135f:	89 f8                	mov    %edi,%eax
    1361:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1364:	31 ff                	xor    %edi,%edi
        ap++;
    1366:	83 c0 04             	add    $0x4,%eax
    1369:	89 45 d4             	mov    %eax,-0x2c(%ebp)
    136c:	e9 37 ff ff ff       	jmp    12a8 <printf+0x48>
    1371:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
    1378:	8b 45 d4             	mov    -0x2c(%ebp),%eax
    137b:	8b 08                	mov    (%eax),%ecx
        ap++;
    137d:	83 c0 04             	add    $0x4,%eax
    1380:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
    1383:	85 c9                	test   %ecx,%ecx
    1385:	0f 84 8e 00 00 00    	je     1419 <printf+0x1b9>
        while(*s != 0){
    138b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
    138e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
    1390:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
    1392:	84 c0                	test   %al,%al
    1394:	0f 84 0e ff ff ff    	je     12a8 <printf+0x48>
    139a:	89 75 d0             	mov    %esi,-0x30(%ebp)
    139d:	89 de                	mov    %ebx,%esi
    139f:	8b 5d 08             	mov    0x8(%ebp),%ebx
    13a2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
    13a5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
    13a8:	83 ec 04             	sub    $0x4,%esp
          s++;
    13ab:	83 c6 01             	add    $0x1,%esi
    13ae:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
    13b1:	6a 01                	push   $0x1
    13b3:	57                   	push   %edi
    13b4:	53                   	push   %ebx
    13b5:	e8 2c fd ff ff       	call   10e6 <write>
        while(*s != 0){
    13ba:	0f b6 06             	movzbl (%esi),%eax
    13bd:	83 c4 10             	add    $0x10,%esp
    13c0:	84 c0                	test   %al,%al
    13c2:	75 e4                	jne    13a8 <printf+0x148>
    13c4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
    13c7:	31 ff                	xor    %edi,%edi
    13c9:	e9 da fe ff ff       	jmp    12a8 <printf+0x48>
    13ce:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
    13d0:	83 ec 0c             	sub    $0xc,%esp
    13d3:	b9 0a 00 00 00       	mov    $0xa,%ecx
    13d8:	6a 01                	push   $0x1
    13da:	e9 73 ff ff ff       	jmp    1352 <printf+0xf2>
    13df:	90                   	nop
  write(fd, &c, 1);
    13e0:	83 ec 04             	sub    $0x4,%esp
    13e3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
    13e6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
    13e9:	6a 01                	push   $0x1
    13eb:	e9 21 ff ff ff       	jmp    1311 <printf+0xb1>
        putc(fd, *ap);
    13f0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
    13f3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
    13f6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
    13f8:	6a 01                	push   $0x1
        ap++;
    13fa:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
    13fd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
    1400:	8d 45 e4             	lea    -0x1c(%ebp),%eax
    1403:	50                   	push   %eax
    1404:	ff 75 08             	pushl  0x8(%ebp)
    1407:	e8 da fc ff ff       	call   10e6 <write>
        ap++;
    140c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
    140f:	83 c4 10             	add    $0x10,%esp
      state = 0;
    1412:	31 ff                	xor    %edi,%edi
    1414:	e9 8f fe ff ff       	jmp    12a8 <printf+0x48>
          s = "(null)";
    1419:	bb f7 16 00 00       	mov    $0x16f7,%ebx
        while(*s != 0){
    141e:	b8 28 00 00 00       	mov    $0x28,%eax
    1423:	e9 72 ff ff ff       	jmp    139a <printf+0x13a>
    1428:	66 90                	xchg   %ax,%ax
    142a:	66 90                	xchg   %ax,%ax
    142c:	66 90                	xchg   %ax,%ax
    142e:	66 90                	xchg   %ax,%ax

00001430 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
    1430:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1431:	a1 f4 1d 00 00       	mov    0x1df4,%eax
{
    1436:	89 e5                	mov    %esp,%ebp
    1438:	57                   	push   %edi
    1439:	56                   	push   %esi
    143a:	53                   	push   %ebx
    143b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
    143e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
    1441:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
    1448:	39 c8                	cmp    %ecx,%eax
    144a:	8b 10                	mov    (%eax),%edx
    144c:	73 32                	jae    1480 <free+0x50>
    144e:	39 d1                	cmp    %edx,%ecx
    1450:	72 04                	jb     1456 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1452:	39 d0                	cmp    %edx,%eax
    1454:	72 32                	jb     1488 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
    1456:	8b 73 fc             	mov    -0x4(%ebx),%esi
    1459:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
    145c:	39 fa                	cmp    %edi,%edx
    145e:	74 30                	je     1490 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
    1460:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    1463:	8b 50 04             	mov    0x4(%eax),%edx
    1466:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    1469:	39 f1                	cmp    %esi,%ecx
    146b:	74 3a                	je     14a7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
    146d:	89 08                	mov    %ecx,(%eax)
  freep = p;
    146f:	a3 f4 1d 00 00       	mov    %eax,0x1df4
}
    1474:	5b                   	pop    %ebx
    1475:	5e                   	pop    %esi
    1476:	5f                   	pop    %edi
    1477:	5d                   	pop    %ebp
    1478:	c3                   	ret    
    1479:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
    1480:	39 d0                	cmp    %edx,%eax
    1482:	72 04                	jb     1488 <free+0x58>
    1484:	39 d1                	cmp    %edx,%ecx
    1486:	72 ce                	jb     1456 <free+0x26>
{
    1488:	89 d0                	mov    %edx,%eax
    148a:	eb bc                	jmp    1448 <free+0x18>
    148c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
    1490:	03 72 04             	add    0x4(%edx),%esi
    1493:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
    1496:	8b 10                	mov    (%eax),%edx
    1498:	8b 12                	mov    (%edx),%edx
    149a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
    149d:	8b 50 04             	mov    0x4(%eax),%edx
    14a0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
    14a3:	39 f1                	cmp    %esi,%ecx
    14a5:	75 c6                	jne    146d <free+0x3d>
    p->s.size += bp->s.size;
    14a7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
    14aa:	a3 f4 1d 00 00       	mov    %eax,0x1df4
    p->s.size += bp->s.size;
    14af:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
    14b2:	8b 53 f8             	mov    -0x8(%ebx),%edx
    14b5:	89 10                	mov    %edx,(%eax)
}
    14b7:	5b                   	pop    %ebx
    14b8:	5e                   	pop    %esi
    14b9:	5f                   	pop    %edi
    14ba:	5d                   	pop    %ebp
    14bb:	c3                   	ret    
    14bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

000014c0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
    14c0:	55                   	push   %ebp
    14c1:	89 e5                	mov    %esp,%ebp
    14c3:	57                   	push   %edi
    14c4:	56                   	push   %esi
    14c5:	53                   	push   %ebx
    14c6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    14c9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
    14cc:	8b 15 f4 1d 00 00    	mov    0x1df4,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
    14d2:	8d 78 07             	lea    0x7(%eax),%edi
    14d5:	c1 ef 03             	shr    $0x3,%edi
    14d8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
    14db:	85 d2                	test   %edx,%edx
    14dd:	0f 84 9d 00 00 00    	je     1580 <malloc+0xc0>
    14e3:	8b 02                	mov    (%edx),%eax
    14e5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
    14e8:	39 cf                	cmp    %ecx,%edi
    14ea:	76 6c                	jbe    1558 <malloc+0x98>
    14ec:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
    14f2:	bb 00 10 00 00       	mov    $0x1000,%ebx
    14f7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
    14fa:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
    1501:	eb 0e                	jmp    1511 <malloc+0x51>
    1503:	90                   	nop
    1504:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    1508:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
    150a:	8b 48 04             	mov    0x4(%eax),%ecx
    150d:	39 f9                	cmp    %edi,%ecx
    150f:	73 47                	jae    1558 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
    1511:	39 05 f4 1d 00 00    	cmp    %eax,0x1df4
    1517:	89 c2                	mov    %eax,%edx
    1519:	75 ed                	jne    1508 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
    151b:	83 ec 0c             	sub    $0xc,%esp
    151e:	56                   	push   %esi
    151f:	e8 2a fc ff ff       	call   114e <sbrk>
  if(p == (char*)-1)
    1524:	83 c4 10             	add    $0x10,%esp
    1527:	83 f8 ff             	cmp    $0xffffffff,%eax
    152a:	74 1c                	je     1548 <malloc+0x88>
  hp->s.size = nu;
    152c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
    152f:	83 ec 0c             	sub    $0xc,%esp
    1532:	83 c0 08             	add    $0x8,%eax
    1535:	50                   	push   %eax
    1536:	e8 f5 fe ff ff       	call   1430 <free>
  return freep;
    153b:	8b 15 f4 1d 00 00    	mov    0x1df4,%edx
      if((p = morecore(nunits)) == 0)
    1541:	83 c4 10             	add    $0x10,%esp
    1544:	85 d2                	test   %edx,%edx
    1546:	75 c0                	jne    1508 <malloc+0x48>
        return 0;
  }
}
    1548:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
    154b:	31 c0                	xor    %eax,%eax
}
    154d:	5b                   	pop    %ebx
    154e:	5e                   	pop    %esi
    154f:	5f                   	pop    %edi
    1550:	5d                   	pop    %ebp
    1551:	c3                   	ret    
    1552:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
    1558:	39 cf                	cmp    %ecx,%edi
    155a:	74 54                	je     15b0 <malloc+0xf0>
        p->s.size -= nunits;
    155c:	29 f9                	sub    %edi,%ecx
    155e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
    1561:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
    1564:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
    1567:	89 15 f4 1d 00 00    	mov    %edx,0x1df4
}
    156d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
    1570:	83 c0 08             	add    $0x8,%eax
}
    1573:	5b                   	pop    %ebx
    1574:	5e                   	pop    %esi
    1575:	5f                   	pop    %edi
    1576:	5d                   	pop    %ebp
    1577:	c3                   	ret    
    1578:	90                   	nop
    1579:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
    1580:	c7 05 f4 1d 00 00 f8 	movl   $0x1df8,0x1df4
    1587:	1d 00 00 
    158a:	c7 05 f8 1d 00 00 f8 	movl   $0x1df8,0x1df8
    1591:	1d 00 00 
    base.s.size = 0;
    1594:	b8 f8 1d 00 00       	mov    $0x1df8,%eax
    1599:	c7 05 fc 1d 00 00 00 	movl   $0x0,0x1dfc
    15a0:	00 00 00 
    15a3:	e9 44 ff ff ff       	jmp    14ec <malloc+0x2c>
    15a8:	90                   	nop
    15a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
    15b0:	8b 08                	mov    (%eax),%ecx
    15b2:	89 0a                	mov    %ecx,(%edx)
    15b4:	eb b1                	jmp    1567 <malloc+0xa7>
