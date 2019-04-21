
_ls:     file format elf32-i386


Disassembly of section .text:

00000000 <mystrcmp>:
#include "ls.h"
// #include "defs.h"

int
mystrcmp (char *s1, char *s2)
{
   0:	55                   	push   %ebp
   1:	89 e5                	mov    %esp,%ebp
   3:	56                   	push   %esi
   4:	53                   	push   %ebx
   5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int a =0,b=0;
   8:	31 db                	xor    %ebx,%ebx
{
   a:	8b 55 0c             	mov    0xc(%ebp),%edx
    while(*s1){a++;s1++;}
   d:	80 39 00             	cmpb   $0x0,(%ecx)
  10:	0f b6 02             	movzbl (%edx),%eax
  13:	74 33                	je     48 <mystrcmp+0x48>
  15:	8d 76 00             	lea    0x0(%esi),%esi
  18:	83 c1 01             	add    $0x1,%ecx
  1b:	83 c3 01             	add    $0x1,%ebx
  1e:	80 39 00             	cmpb   $0x0,(%ecx)
  21:	75 f5                	jne    18 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
  23:	84 c0                	test   %al,%al
  25:	74 51                	je     78 <mystrcmp+0x78>
    int a =0,b=0;
  27:	31 f6                	xor    %esi,%esi
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
  30:	83 c2 01             	add    $0x1,%edx
  33:	83 c6 01             	add    $0x1,%esi
  36:	80 3a 00             	cmpb   $0x0,(%edx)
  39:	75 f5                	jne    30 <mystrcmp+0x30>

    if(a!=b)return 0;
  3b:	31 c0                	xor    %eax,%eax
  3d:	39 de                	cmp    %ebx,%esi
  3f:	74 0f                	je     50 <mystrcmp+0x50>
    // printf("here");
    while(a--){
        if(*s1++ != *s2++)return 0;
    }
    return 1;
}
  41:	5b                   	pop    %ebx
  42:	5e                   	pop    %esi
  43:	5d                   	pop    %ebp
  44:	c3                   	ret    
  45:	8d 76 00             	lea    0x0(%esi),%esi
    while(*s2){b++;s2++;}
  48:	84 c0                	test   %al,%al
  4a:	75 db                	jne    27 <mystrcmp+0x27>
  4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  50:	01 d3                	add    %edx,%ebx
  52:	eb 13                	jmp    67 <mystrcmp+0x67>
  54:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(*s1++ != *s2++)return 0;
  58:	83 c2 01             	add    $0x1,%edx
  5b:	83 c1 01             	add    $0x1,%ecx
  5e:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
  62:	38 41 ff             	cmp    %al,-0x1(%ecx)
  65:	75 11                	jne    78 <mystrcmp+0x78>
    while(a--){
  67:	39 d3                	cmp    %edx,%ebx
  69:	75 ed                	jne    58 <mystrcmp+0x58>
}
  6b:	5b                   	pop    %ebx
    return 1;
  6c:	b8 01 00 00 00       	mov    $0x1,%eax
}
  71:	5e                   	pop    %esi
  72:	5d                   	pop    %ebp
  73:	c3                   	ret    
  74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  78:	5b                   	pop    %ebx
    if(a!=b)return 0;
  79:	31 c0                	xor    %eax,%eax
}
  7b:	5e                   	pop    %esi
  7c:	5d                   	pop    %ebp
  7d:	c3                   	ret    
  7e:	66 90                	xchg   %ax,%ax

00000080 <fmtname>:

char*
fmtname(char *path)
{
  80:	55                   	push   %ebp
  81:	89 e5                	mov    %esp,%ebp
  83:	56                   	push   %esi
  84:	53                   	push   %ebx
  85:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
  88:	83 ec 0c             	sub    $0xc,%esp
  8b:	53                   	push   %ebx
  8c:	e8 9f 03 00 00       	call   430 <strlen>
  91:	83 c4 10             	add    $0x10,%esp
  94:	01 d8                	add    %ebx,%eax
  96:	73 0f                	jae    a7 <fmtname+0x27>
  98:	eb 12                	jmp    ac <fmtname+0x2c>
  9a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  a0:	83 e8 01             	sub    $0x1,%eax
  a3:	39 c3                	cmp    %eax,%ebx
  a5:	77 05                	ja     ac <fmtname+0x2c>
  a7:	80 38 2f             	cmpb   $0x2f,(%eax)
  aa:	75 f4                	jne    a0 <fmtname+0x20>
    ;
  p++;
  ac:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
  af:	83 ec 0c             	sub    $0xc,%esp
  b2:	53                   	push   %ebx
  b3:	e8 78 03 00 00       	call   430 <strlen>
  b8:	83 c4 10             	add    $0x10,%esp
  bb:	83 f8 0d             	cmp    $0xd,%eax
  be:	77 4a                	ja     10a <fmtname+0x8a>
    return p;
  memmove(buf, p, strlen(p));
  c0:	83 ec 0c             	sub    $0xc,%esp
  c3:	53                   	push   %ebx
  c4:	e8 67 03 00 00       	call   430 <strlen>
  c9:	83 c4 0c             	add    $0xc,%esp
  cc:	50                   	push   %eax
  cd:	53                   	push   %ebx
  ce:	68 a0 0e 00 00       	push   $0xea0
  d3:	e8 f8 04 00 00       	call   5d0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  d8:	89 1c 24             	mov    %ebx,(%esp)
  db:	e8 50 03 00 00       	call   430 <strlen>
  e0:	89 1c 24             	mov    %ebx,(%esp)
  e3:	89 c6                	mov    %eax,%esi
  return buf;
  e5:	bb a0 0e 00 00       	mov    $0xea0,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
  ea:	e8 41 03 00 00       	call   430 <strlen>
  ef:	ba 0e 00 00 00       	mov    $0xe,%edx
  f4:	83 c4 0c             	add    $0xc,%esp
  f7:	05 a0 0e 00 00       	add    $0xea0,%eax
  fc:	29 f2                	sub    %esi,%edx
  fe:	52                   	push   %edx
  ff:	6a 20                	push   $0x20
 101:	50                   	push   %eax
 102:	e8 59 03 00 00       	call   460 <memset>
  return buf;
 107:	83 c4 10             	add    $0x10,%esp
}
 10a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 10d:	89 d8                	mov    %ebx,%eax
 10f:	5b                   	pop    %ebx
 110:	5e                   	pop    %esi
 111:	5d                   	pop    %ebp
 112:	c3                   	ret    
 113:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 119:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000120 <ls>:

void
ls(char *path)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	57                   	push   %edi
 124:	56                   	push   %esi
 125:	53                   	push   %ebx
 126:	81 ec 5c 02 00 00    	sub    $0x25c,%esp

  int cid = getcid();
 12c:	e8 b9 05 00 00       	call   6ea <getcid>

  printf(2, "Cid is: %d\n", cid);
 131:	83 ec 04             	sub    $0x4,%esp
  int cid = getcid();
 134:	89 c7                	mov    %eax,%edi
  printf(2, "Cid is: %d\n", cid);
 136:	50                   	push   %eax
 137:	68 f8 0a 00 00       	push   $0xaf8
 13c:	6a 02                	push   $0x2
 13e:	e8 5d 06 00 00       	call   7a0 <printf>
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  if((fd = open(path, 0)) < 0){
 143:	59                   	pop    %ecx
 144:	5b                   	pop    %ebx
 145:	6a 00                	push   $0x0
 147:	ff 75 08             	pushl  0x8(%ebp)
 14a:	e8 f3 04 00 00       	call   642 <open>
 14f:	83 c4 10             	add    $0x10,%esp
 152:	85 c0                	test   %eax,%eax
 154:	78 5a                	js     1b0 <ls+0x90>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 156:	8d b5 d0 fd ff ff    	lea    -0x230(%ebp),%esi
 15c:	83 ec 08             	sub    $0x8,%esp
 15f:	89 c3                	mov    %eax,%ebx
 161:	56                   	push   %esi
 162:	50                   	push   %eax
 163:	e8 f2 04 00 00       	call   65a <fstat>
 168:	83 c4 10             	add    $0x10,%esp
 16b:	85 c0                	test   %eax,%eax
 16d:	0f 88 cd 00 00 00    	js     240 <ls+0x120>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  switch(st.type){
 173:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 17a:	66 83 f8 01          	cmp    $0x1,%ax
 17e:	74 50                	je     1d0 <ls+0xb0>
 180:	66 83 f8 02          	cmp    $0x2,%ax
 184:	75 12                	jne    198 <ls+0x78>
  case T_FILE:
    if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 186:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 18c:	8d 42 01             	lea    0x1(%edx),%eax
 18f:	83 f8 01             	cmp    $0x1,%eax
 192:	76 6c                	jbe    200 <ls+0xe0>
 194:	39 fa                	cmp    %edi,%edx
 196:	74 68                	je     200 <ls+0xe0>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
    }
    break;
  }
  close(fd);
 198:	83 ec 0c             	sub    $0xc,%esp
 19b:	53                   	push   %ebx
 19c:	e8 89 04 00 00       	call   62a <close>
 1a1:	83 c4 10             	add    $0x10,%esp

}
 1a4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1a7:	5b                   	pop    %ebx
 1a8:	5e                   	pop    %esi
 1a9:	5f                   	pop    %edi
 1aa:	5d                   	pop    %ebp
 1ab:	c3                   	ret    
 1ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
 1b0:	83 ec 04             	sub    $0x4,%esp
 1b3:	ff 75 08             	pushl  0x8(%ebp)
 1b6:	68 04 0b 00 00       	push   $0xb04
 1bb:	6a 02                	push   $0x2
 1bd:	e8 de 05 00 00       	call   7a0 <printf>
    return;
 1c2:	83 c4 10             	add    $0x10,%esp
}
 1c5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1c8:	5b                   	pop    %ebx
 1c9:	5e                   	pop    %esi
 1ca:	5f                   	pop    %edi
 1cb:	5d                   	pop    %ebp
 1cc:	c3                   	ret    
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 1d0:	83 ec 0c             	sub    $0xc,%esp
 1d3:	ff 75 08             	pushl  0x8(%ebp)
 1d6:	e8 55 02 00 00       	call   430 <strlen>
 1db:	83 c0 10             	add    $0x10,%eax
 1de:	83 c4 10             	add    $0x10,%esp
 1e1:	3d 00 02 00 00       	cmp    $0x200,%eax
 1e6:	0f 86 7c 00 00 00    	jbe    268 <ls+0x148>
      printf(1, "ls: path too long\n");
 1ec:	83 ec 08             	sub    $0x8,%esp
 1ef:	68 3c 0b 00 00       	push   $0xb3c
 1f4:	6a 01                	push   $0x1
 1f6:	e8 a5 05 00 00       	call   7a0 <printf>
      break;
 1fb:	83 c4 10             	add    $0x10,%esp
 1fe:	eb 98                	jmp    198 <ls+0x78>
    printf(1, "%s %d %d %d %d\n", fmtname(path), st.type, st.ino, st.size, st.cid);
 200:	83 ec 0c             	sub    $0xc,%esp
 203:	ff 75 08             	pushl  0x8(%ebp)
 206:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 20c:	8b bd e0 fd ff ff    	mov    -0x220(%ebp),%edi
 212:	8b b5 d8 fd ff ff    	mov    -0x228(%ebp),%esi
 218:	e8 63 fe ff ff       	call   80 <fmtname>
 21d:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 223:	83 c4 0c             	add    $0xc,%esp
 226:	52                   	push   %edx
 227:	57                   	push   %edi
 228:	56                   	push   %esi
 229:	6a 02                	push   $0x2
 22b:	50                   	push   %eax
 22c:	68 2c 0b 00 00       	push   $0xb2c
 231:	6a 01                	push   $0x1
 233:	e8 68 05 00 00       	call   7a0 <printf>
    break;
 238:	83 c4 20             	add    $0x20,%esp
 23b:	e9 58 ff ff ff       	jmp    198 <ls+0x78>
    printf(2, "ls: cannot stat %s\n", path);
 240:	83 ec 04             	sub    $0x4,%esp
 243:	ff 75 08             	pushl  0x8(%ebp)
 246:	68 18 0b 00 00       	push   $0xb18
 24b:	6a 02                	push   $0x2
 24d:	e8 4e 05 00 00       	call   7a0 <printf>
    close(fd);
 252:	89 1c 24             	mov    %ebx,(%esp)
 255:	e8 d0 03 00 00       	call   62a <close>
    return;
 25a:	83 c4 10             	add    $0x10,%esp
}
 25d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 260:	5b                   	pop    %ebx
 261:	5e                   	pop    %esi
 262:	5f                   	pop    %edi
 263:	5d                   	pop    %ebp
 264:	c3                   	ret    
 265:	8d 76 00             	lea    0x0(%esi),%esi
    strcpy(buf, path);
 268:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 26e:	83 ec 08             	sub    $0x8,%esp
 271:	ff 75 08             	pushl  0x8(%ebp)
 274:	50                   	push   %eax
 275:	e8 36 01 00 00       	call   3b0 <strcpy>
    p = buf+strlen(buf);
 27a:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 280:	89 04 24             	mov    %eax,(%esp)
 283:	e8 a8 01 00 00       	call   430 <strlen>
 288:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 28e:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 291:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 293:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 296:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 29c:	c6 00 2f             	movb   $0x2f,(%eax)
 29f:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 2a5:	8d 76 00             	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 2a8:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
 2ae:	83 ec 04             	sub    $0x4,%esp
 2b1:	6a 10                	push   $0x10
 2b3:	50                   	push   %eax
 2b4:	53                   	push   %ebx
 2b5:	e8 60 03 00 00       	call   61a <read>
 2ba:	83 c4 10             	add    $0x10,%esp
 2bd:	83 f8 10             	cmp    $0x10,%eax
 2c0:	0f 85 d2 fe ff ff    	jne    198 <ls+0x78>
      if(de.inum == 0)
 2c6:	66 83 bd c0 fd ff ff 	cmpw   $0x0,-0x240(%ebp)
 2cd:	00 
 2ce:	74 d8                	je     2a8 <ls+0x188>
      memmove(p, de.name, DIRSIZ);
 2d0:	8d 85 c2 fd ff ff    	lea    -0x23e(%ebp),%eax
 2d6:	83 ec 04             	sub    $0x4,%esp
 2d9:	6a 0e                	push   $0xe
 2db:	50                   	push   %eax
 2dc:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 2e2:	e8 e9 02 00 00       	call   5d0 <memmove>
      p[DIRSIZ] = 0;
 2e7:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 2ed:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 2f1:	58                   	pop    %eax
 2f2:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 2f8:	5a                   	pop    %edx
 2f9:	56                   	push   %esi
 2fa:	50                   	push   %eax
 2fb:	e8 40 02 00 00       	call   540 <stat>
 300:	83 c4 10             	add    $0x10,%esp
 303:	85 c0                	test   %eax,%eax
 305:	0f 88 85 00 00 00    	js     390 <ls+0x270>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 30b:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 311:	8d 42 01             	lea    0x1(%edx),%eax
 314:	83 f8 01             	cmp    $0x1,%eax
 317:	76 04                	jbe    31d <ls+0x1fd>
 319:	39 fa                	cmp    %edi,%edx
 31b:	75 8b                	jne    2a8 <ls+0x188>
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
 31d:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
 323:	89 95 a0 fd ff ff    	mov    %edx,-0x260(%ebp)
 329:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 32f:	83 ec 0c             	sub    $0xc,%esp
 332:	8b 85 d8 fd ff ff    	mov    -0x228(%ebp),%eax
 338:	52                   	push   %edx
 339:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 33f:	0f bf 8d d0 fd ff ff 	movswl -0x230(%ebp),%ecx
 346:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 34c:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 352:	e8 29 fd ff ff       	call   80 <fmtname>
 357:	8b 95 a0 fd ff ff    	mov    -0x260(%ebp),%edx
 35d:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
 363:	83 c4 0c             	add    $0xc,%esp
 366:	52                   	push   %edx
 367:	51                   	push   %ecx
 368:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 36e:	ff b5 a8 fd ff ff    	pushl  -0x258(%ebp)
 374:	50                   	push   %eax
 375:	68 2c 0b 00 00       	push   $0xb2c
 37a:	6a 01                	push   $0x1
 37c:	e8 1f 04 00 00       	call   7a0 <printf>
 381:	83 c4 20             	add    $0x20,%esp
 384:	e9 1f ff ff ff       	jmp    2a8 <ls+0x188>
 389:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 390:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 396:	83 ec 04             	sub    $0x4,%esp
 399:	50                   	push   %eax
 39a:	68 18 0b 00 00       	push   $0xb18
 39f:	6a 01                	push   $0x1
 3a1:	e8 fa 03 00 00       	call   7a0 <printf>
        continue;
 3a6:	83 c4 10             	add    $0x10,%esp
 3a9:	e9 fa fe ff ff       	jmp    2a8 <ls+0x188>
 3ae:	66 90                	xchg   %ax,%ax

000003b0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 3b0:	55                   	push   %ebp
 3b1:	89 e5                	mov    %esp,%ebp
 3b3:	53                   	push   %ebx
 3b4:	8b 45 08             	mov    0x8(%ebp),%eax
 3b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 3ba:	89 c2                	mov    %eax,%edx
 3bc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3c0:	83 c1 01             	add    $0x1,%ecx
 3c3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 3c7:	83 c2 01             	add    $0x1,%edx
 3ca:	84 db                	test   %bl,%bl
 3cc:	88 5a ff             	mov    %bl,-0x1(%edx)
 3cf:	75 ef                	jne    3c0 <strcpy+0x10>
    ;
  return os;
}
 3d1:	5b                   	pop    %ebx
 3d2:	5d                   	pop    %ebp
 3d3:	c3                   	ret    
 3d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000003e0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 3e0:	55                   	push   %ebp
 3e1:	89 e5                	mov    %esp,%ebp
 3e3:	53                   	push   %ebx
 3e4:	8b 55 08             	mov    0x8(%ebp),%edx
 3e7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 3ea:	0f b6 02             	movzbl (%edx),%eax
 3ed:	0f b6 19             	movzbl (%ecx),%ebx
 3f0:	84 c0                	test   %al,%al
 3f2:	75 1c                	jne    410 <strcmp+0x30>
 3f4:	eb 2a                	jmp    420 <strcmp+0x40>
 3f6:	8d 76 00             	lea    0x0(%esi),%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 400:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 403:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 406:	83 c1 01             	add    $0x1,%ecx
 409:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 40c:	84 c0                	test   %al,%al
 40e:	74 10                	je     420 <strcmp+0x40>
 410:	38 d8                	cmp    %bl,%al
 412:	74 ec                	je     400 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 414:	29 d8                	sub    %ebx,%eax
}
 416:	5b                   	pop    %ebx
 417:	5d                   	pop    %ebp
 418:	c3                   	ret    
 419:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 420:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 422:	29 d8                	sub    %ebx,%eax
}
 424:	5b                   	pop    %ebx
 425:	5d                   	pop    %ebp
 426:	c3                   	ret    
 427:	89 f6                	mov    %esi,%esi
 429:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000430 <strlen>:

uint
strlen(const char *s)
{
 430:	55                   	push   %ebp
 431:	89 e5                	mov    %esp,%ebp
 433:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 436:	80 39 00             	cmpb   $0x0,(%ecx)
 439:	74 15                	je     450 <strlen+0x20>
 43b:	31 d2                	xor    %edx,%edx
 43d:	8d 76 00             	lea    0x0(%esi),%esi
 440:	83 c2 01             	add    $0x1,%edx
 443:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 447:	89 d0                	mov    %edx,%eax
 449:	75 f5                	jne    440 <strlen+0x10>
    ;
  return n;
}
 44b:	5d                   	pop    %ebp
 44c:	c3                   	ret    
 44d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 450:	31 c0                	xor    %eax,%eax
}
 452:	5d                   	pop    %ebp
 453:	c3                   	ret    
 454:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 45a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000460 <memset>:

void*
memset(void *dst, int c, uint n)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 467:	8b 4d 10             	mov    0x10(%ebp),%ecx
 46a:	8b 45 0c             	mov    0xc(%ebp),%eax
 46d:	89 d7                	mov    %edx,%edi
 46f:	fc                   	cld    
 470:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 472:	89 d0                	mov    %edx,%eax
 474:	5f                   	pop    %edi
 475:	5d                   	pop    %ebp
 476:	c3                   	ret    
 477:	89 f6                	mov    %esi,%esi
 479:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000480 <strchr>:

char*
strchr(const char *s, char c)
{
 480:	55                   	push   %ebp
 481:	89 e5                	mov    %esp,%ebp
 483:	53                   	push   %ebx
 484:	8b 45 08             	mov    0x8(%ebp),%eax
 487:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 48a:	0f b6 10             	movzbl (%eax),%edx
 48d:	84 d2                	test   %dl,%dl
 48f:	74 1d                	je     4ae <strchr+0x2e>
    if(*s == c)
 491:	38 d3                	cmp    %dl,%bl
 493:	89 d9                	mov    %ebx,%ecx
 495:	75 0d                	jne    4a4 <strchr+0x24>
 497:	eb 17                	jmp    4b0 <strchr+0x30>
 499:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 4a0:	38 ca                	cmp    %cl,%dl
 4a2:	74 0c                	je     4b0 <strchr+0x30>
  for(; *s; s++)
 4a4:	83 c0 01             	add    $0x1,%eax
 4a7:	0f b6 10             	movzbl (%eax),%edx
 4aa:	84 d2                	test   %dl,%dl
 4ac:	75 f2                	jne    4a0 <strchr+0x20>
      return (char*)s;
  return 0;
 4ae:	31 c0                	xor    %eax,%eax
}
 4b0:	5b                   	pop    %ebx
 4b1:	5d                   	pop    %ebp
 4b2:	c3                   	ret    
 4b3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004c0 <gets>:

char*
gets(char *buf, int max)
{
 4c0:	55                   	push   %ebp
 4c1:	89 e5                	mov    %esp,%ebp
 4c3:	57                   	push   %edi
 4c4:	56                   	push   %esi
 4c5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 4c6:	31 f6                	xor    %esi,%esi
 4c8:	89 f3                	mov    %esi,%ebx
{
 4ca:	83 ec 1c             	sub    $0x1c,%esp
 4cd:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 4d0:	eb 2f                	jmp    501 <gets+0x41>
 4d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 4d8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 4db:	83 ec 04             	sub    $0x4,%esp
 4de:	6a 01                	push   $0x1
 4e0:	50                   	push   %eax
 4e1:	6a 00                	push   $0x0
 4e3:	e8 32 01 00 00       	call   61a <read>
    if(cc < 1)
 4e8:	83 c4 10             	add    $0x10,%esp
 4eb:	85 c0                	test   %eax,%eax
 4ed:	7e 1c                	jle    50b <gets+0x4b>
      break;
    buf[i++] = c;
 4ef:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 4f3:	83 c7 01             	add    $0x1,%edi
 4f6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 4f9:	3c 0a                	cmp    $0xa,%al
 4fb:	74 23                	je     520 <gets+0x60>
 4fd:	3c 0d                	cmp    $0xd,%al
 4ff:	74 1f                	je     520 <gets+0x60>
  for(i=0; i+1 < max; ){
 501:	83 c3 01             	add    $0x1,%ebx
 504:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 507:	89 fe                	mov    %edi,%esi
 509:	7c cd                	jl     4d8 <gets+0x18>
 50b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 50d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 510:	c6 03 00             	movb   $0x0,(%ebx)
}
 513:	8d 65 f4             	lea    -0xc(%ebp),%esp
 516:	5b                   	pop    %ebx
 517:	5e                   	pop    %esi
 518:	5f                   	pop    %edi
 519:	5d                   	pop    %ebp
 51a:	c3                   	ret    
 51b:	90                   	nop
 51c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 520:	8b 75 08             	mov    0x8(%ebp),%esi
 523:	8b 45 08             	mov    0x8(%ebp),%eax
 526:	01 de                	add    %ebx,%esi
 528:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 52a:	c6 03 00             	movb   $0x0,(%ebx)
}
 52d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 530:	5b                   	pop    %ebx
 531:	5e                   	pop    %esi
 532:	5f                   	pop    %edi
 533:	5d                   	pop    %ebp
 534:	c3                   	ret    
 535:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 539:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000540 <stat>:

int
stat(const char *n, struct stat *st)
{
 540:	55                   	push   %ebp
 541:	89 e5                	mov    %esp,%ebp
 543:	56                   	push   %esi
 544:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 545:	83 ec 08             	sub    $0x8,%esp
 548:	6a 00                	push   $0x0
 54a:	ff 75 08             	pushl  0x8(%ebp)
 54d:	e8 f0 00 00 00       	call   642 <open>
  if(fd < 0)
 552:	83 c4 10             	add    $0x10,%esp
 555:	85 c0                	test   %eax,%eax
 557:	78 27                	js     580 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 559:	83 ec 08             	sub    $0x8,%esp
 55c:	ff 75 0c             	pushl  0xc(%ebp)
 55f:	89 c3                	mov    %eax,%ebx
 561:	50                   	push   %eax
 562:	e8 f3 00 00 00       	call   65a <fstat>
  close(fd);
 567:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 56a:	89 c6                	mov    %eax,%esi
  close(fd);
 56c:	e8 b9 00 00 00       	call   62a <close>
  return r;
 571:	83 c4 10             	add    $0x10,%esp
}
 574:	8d 65 f8             	lea    -0x8(%ebp),%esp
 577:	89 f0                	mov    %esi,%eax
 579:	5b                   	pop    %ebx
 57a:	5e                   	pop    %esi
 57b:	5d                   	pop    %ebp
 57c:	c3                   	ret    
 57d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 580:	be ff ff ff ff       	mov    $0xffffffff,%esi
 585:	eb ed                	jmp    574 <stat+0x34>
 587:	89 f6                	mov    %esi,%esi
 589:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000590 <atoi>:

int
atoi(const char *s)
{
 590:	55                   	push   %ebp
 591:	89 e5                	mov    %esp,%ebp
 593:	53                   	push   %ebx
 594:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 597:	0f be 11             	movsbl (%ecx),%edx
 59a:	8d 42 d0             	lea    -0x30(%edx),%eax
 59d:	3c 09                	cmp    $0x9,%al
  n = 0;
 59f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 5a4:	77 1f                	ja     5c5 <atoi+0x35>
 5a6:	8d 76 00             	lea    0x0(%esi),%esi
 5a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 5b0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 5b3:	83 c1 01             	add    $0x1,%ecx
 5b6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 5ba:	0f be 11             	movsbl (%ecx),%edx
 5bd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 5c0:	80 fb 09             	cmp    $0x9,%bl
 5c3:	76 eb                	jbe    5b0 <atoi+0x20>
  return n;
}
 5c5:	5b                   	pop    %ebx
 5c6:	5d                   	pop    %ebp
 5c7:	c3                   	ret    
 5c8:	90                   	nop
 5c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000005d0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 5d0:	55                   	push   %ebp
 5d1:	89 e5                	mov    %esp,%ebp
 5d3:	56                   	push   %esi
 5d4:	53                   	push   %ebx
 5d5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 5d8:	8b 45 08             	mov    0x8(%ebp),%eax
 5db:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 5de:	85 db                	test   %ebx,%ebx
 5e0:	7e 14                	jle    5f6 <memmove+0x26>
 5e2:	31 d2                	xor    %edx,%edx
 5e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 5e8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 5ec:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 5ef:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 5f2:	39 d3                	cmp    %edx,%ebx
 5f4:	75 f2                	jne    5e8 <memmove+0x18>
  return vdst;
}
 5f6:	5b                   	pop    %ebx
 5f7:	5e                   	pop    %esi
 5f8:	5d                   	pop    %ebp
 5f9:	c3                   	ret    

000005fa <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 5fa:	b8 01 00 00 00       	mov    $0x1,%eax
 5ff:	cd 40                	int    $0x40
 601:	c3                   	ret    

00000602 <exit>:
SYSCALL(exit)
 602:	b8 02 00 00 00       	mov    $0x2,%eax
 607:	cd 40                	int    $0x40
 609:	c3                   	ret    

0000060a <wait>:
SYSCALL(wait)
 60a:	b8 03 00 00 00       	mov    $0x3,%eax
 60f:	cd 40                	int    $0x40
 611:	c3                   	ret    

00000612 <pipe>:
SYSCALL(pipe)
 612:	b8 04 00 00 00       	mov    $0x4,%eax
 617:	cd 40                	int    $0x40
 619:	c3                   	ret    

0000061a <read>:
SYSCALL(read)
 61a:	b8 05 00 00 00       	mov    $0x5,%eax
 61f:	cd 40                	int    $0x40
 621:	c3                   	ret    

00000622 <write>:
SYSCALL(write)
 622:	b8 10 00 00 00       	mov    $0x10,%eax
 627:	cd 40                	int    $0x40
 629:	c3                   	ret    

0000062a <close>:
SYSCALL(close)
 62a:	b8 15 00 00 00       	mov    $0x15,%eax
 62f:	cd 40                	int    $0x40
 631:	c3                   	ret    

00000632 <kill>:
SYSCALL(kill)
 632:	b8 06 00 00 00       	mov    $0x6,%eax
 637:	cd 40                	int    $0x40
 639:	c3                   	ret    

0000063a <exec>:
SYSCALL(exec)
 63a:	b8 07 00 00 00       	mov    $0x7,%eax
 63f:	cd 40                	int    $0x40
 641:	c3                   	ret    

00000642 <open>:
SYSCALL(open)
 642:	b8 0f 00 00 00       	mov    $0xf,%eax
 647:	cd 40                	int    $0x40
 649:	c3                   	ret    

0000064a <mknod>:
SYSCALL(mknod)
 64a:	b8 11 00 00 00       	mov    $0x11,%eax
 64f:	cd 40                	int    $0x40
 651:	c3                   	ret    

00000652 <unlink>:
SYSCALL(unlink)
 652:	b8 12 00 00 00       	mov    $0x12,%eax
 657:	cd 40                	int    $0x40
 659:	c3                   	ret    

0000065a <fstat>:
SYSCALL(fstat)
 65a:	b8 08 00 00 00       	mov    $0x8,%eax
 65f:	cd 40                	int    $0x40
 661:	c3                   	ret    

00000662 <link>:
SYSCALL(link)
 662:	b8 13 00 00 00       	mov    $0x13,%eax
 667:	cd 40                	int    $0x40
 669:	c3                   	ret    

0000066a <mkdir>:
SYSCALL(mkdir)
 66a:	b8 14 00 00 00       	mov    $0x14,%eax
 66f:	cd 40                	int    $0x40
 671:	c3                   	ret    

00000672 <chdir>:
SYSCALL(chdir)
 672:	b8 09 00 00 00       	mov    $0x9,%eax
 677:	cd 40                	int    $0x40
 679:	c3                   	ret    

0000067a <dup>:
SYSCALL(dup)
 67a:	b8 0a 00 00 00       	mov    $0xa,%eax
 67f:	cd 40                	int    $0x40
 681:	c3                   	ret    

00000682 <getpid>:
SYSCALL(getpid)
 682:	b8 0b 00 00 00       	mov    $0xb,%eax
 687:	cd 40                	int    $0x40
 689:	c3                   	ret    

0000068a <sbrk>:
SYSCALL(sbrk)
 68a:	b8 0c 00 00 00       	mov    $0xc,%eax
 68f:	cd 40                	int    $0x40
 691:	c3                   	ret    

00000692 <sleep>:
SYSCALL(sleep)
 692:	b8 0d 00 00 00       	mov    $0xd,%eax
 697:	cd 40                	int    $0x40
 699:	c3                   	ret    

0000069a <uptime>:
SYSCALL(uptime)
 69a:	b8 0e 00 00 00       	mov    $0xe,%eax
 69f:	cd 40                	int    $0x40
 6a1:	c3                   	ret    

000006a2 <halt>:
SYSCALL(halt)
 6a2:	b8 16 00 00 00       	mov    $0x16,%eax
 6a7:	cd 40                	int    $0x40
 6a9:	c3                   	ret    

000006aa <toggle>:
SYSCALL(toggle)
 6aa:	b8 17 00 00 00       	mov    $0x17,%eax
 6af:	cd 40                	int    $0x40
 6b1:	c3                   	ret    

000006b2 <ps>:
SYSCALL(ps)
 6b2:	b8 18 00 00 00       	mov    $0x18,%eax
 6b7:	cd 40                	int    $0x40
 6b9:	c3                   	ret    

000006ba <create_container>:
SYSCALL(create_container)
 6ba:	b8 1c 00 00 00       	mov    $0x1c,%eax
 6bf:	cd 40                	int    $0x40
 6c1:	c3                   	ret    

000006c2 <destroy_container>:
SYSCALL(destroy_container)
 6c2:	b8 19 00 00 00       	mov    $0x19,%eax
 6c7:	cd 40                	int    $0x40
 6c9:	c3                   	ret    

000006ca <join_container>:
SYSCALL(join_container)
 6ca:	b8 1a 00 00 00       	mov    $0x1a,%eax
 6cf:	cd 40                	int    $0x40
 6d1:	c3                   	ret    

000006d2 <leave_container>:
SYSCALL(leave_container)
 6d2:	b8 1b 00 00 00       	mov    $0x1b,%eax
 6d7:	cd 40                	int    $0x40
 6d9:	c3                   	ret    

000006da <send>:
SYSCALL(send)
 6da:	b8 1d 00 00 00       	mov    $0x1d,%eax
 6df:	cd 40                	int    $0x40
 6e1:	c3                   	ret    

000006e2 <recv>:
SYSCALL(recv)
 6e2:	b8 1e 00 00 00       	mov    $0x1e,%eax
 6e7:	cd 40                	int    $0x40
 6e9:	c3                   	ret    

000006ea <getcid>:
SYSCALL(getcid)
 6ea:	b8 1f 00 00 00       	mov    $0x1f,%eax
 6ef:	cd 40                	int    $0x40
 6f1:	c3                   	ret    
 6f2:	66 90                	xchg   %ax,%ax
 6f4:	66 90                	xchg   %ax,%ax
 6f6:	66 90                	xchg   %ax,%ax
 6f8:	66 90                	xchg   %ax,%ax
 6fa:	66 90                	xchg   %ax,%ax
 6fc:	66 90                	xchg   %ax,%ax
 6fe:	66 90                	xchg   %ax,%ax

00000700 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 700:	55                   	push   %ebp
 701:	89 e5                	mov    %esp,%ebp
 703:	57                   	push   %edi
 704:	56                   	push   %esi
 705:	53                   	push   %ebx
 706:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 709:	85 d2                	test   %edx,%edx
{
 70b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 70e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 710:	79 76                	jns    788 <printint+0x88>
 712:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 716:	74 70                	je     788 <printint+0x88>
    x = -xx;
 718:	f7 d8                	neg    %eax
    neg = 1;
 71a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 721:	31 f6                	xor    %esi,%esi
 723:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 726:	eb 0a                	jmp    732 <printint+0x32>
 728:	90                   	nop
 729:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 730:	89 fe                	mov    %edi,%esi
 732:	31 d2                	xor    %edx,%edx
 734:	8d 7e 01             	lea    0x1(%esi),%edi
 737:	f7 f1                	div    %ecx
 739:	0f b6 92 58 0b 00 00 	movzbl 0xb58(%edx),%edx
  }while((x /= base) != 0);
 740:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 742:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 745:	75 e9                	jne    730 <printint+0x30>
  if(neg)
 747:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 74a:	85 c0                	test   %eax,%eax
 74c:	74 08                	je     756 <printint+0x56>
    buf[i++] = '-';
 74e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 753:	8d 7e 02             	lea    0x2(%esi),%edi
 756:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 75a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 75d:	8d 76 00             	lea    0x0(%esi),%esi
 760:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 763:	83 ec 04             	sub    $0x4,%esp
 766:	83 ee 01             	sub    $0x1,%esi
 769:	6a 01                	push   $0x1
 76b:	53                   	push   %ebx
 76c:	57                   	push   %edi
 76d:	88 45 d7             	mov    %al,-0x29(%ebp)
 770:	e8 ad fe ff ff       	call   622 <write>

  while(--i >= 0)
 775:	83 c4 10             	add    $0x10,%esp
 778:	39 de                	cmp    %ebx,%esi
 77a:	75 e4                	jne    760 <printint+0x60>
    putc(fd, buf[i]);
}
 77c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 77f:	5b                   	pop    %ebx
 780:	5e                   	pop    %esi
 781:	5f                   	pop    %edi
 782:	5d                   	pop    %ebp
 783:	c3                   	ret    
 784:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 788:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 78f:	eb 90                	jmp    721 <printint+0x21>
 791:	eb 0d                	jmp    7a0 <printf>
 793:	90                   	nop
 794:	90                   	nop
 795:	90                   	nop
 796:	90                   	nop
 797:	90                   	nop
 798:	90                   	nop
 799:	90                   	nop
 79a:	90                   	nop
 79b:	90                   	nop
 79c:	90                   	nop
 79d:	90                   	nop
 79e:	90                   	nop
 79f:	90                   	nop

000007a0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 7a0:	55                   	push   %ebp
 7a1:	89 e5                	mov    %esp,%ebp
 7a3:	57                   	push   %edi
 7a4:	56                   	push   %esi
 7a5:	53                   	push   %ebx
 7a6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7a9:	8b 75 0c             	mov    0xc(%ebp),%esi
 7ac:	0f b6 1e             	movzbl (%esi),%ebx
 7af:	84 db                	test   %bl,%bl
 7b1:	0f 84 b3 00 00 00    	je     86a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 7b7:	8d 45 10             	lea    0x10(%ebp),%eax
 7ba:	83 c6 01             	add    $0x1,%esi
  state = 0;
 7bd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 7bf:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 7c2:	eb 2f                	jmp    7f3 <printf+0x53>
 7c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 7c8:	83 f8 25             	cmp    $0x25,%eax
 7cb:	0f 84 a7 00 00 00    	je     878 <printf+0xd8>
  write(fd, &c, 1);
 7d1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 7d4:	83 ec 04             	sub    $0x4,%esp
 7d7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 7da:	6a 01                	push   $0x1
 7dc:	50                   	push   %eax
 7dd:	ff 75 08             	pushl  0x8(%ebp)
 7e0:	e8 3d fe ff ff       	call   622 <write>
 7e5:	83 c4 10             	add    $0x10,%esp
 7e8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 7eb:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 7ef:	84 db                	test   %bl,%bl
 7f1:	74 77                	je     86a <printf+0xca>
    if(state == 0){
 7f3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 7f5:	0f be cb             	movsbl %bl,%ecx
 7f8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 7fb:	74 cb                	je     7c8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 7fd:	83 ff 25             	cmp    $0x25,%edi
 800:	75 e6                	jne    7e8 <printf+0x48>
      if(c == 'd'){
 802:	83 f8 64             	cmp    $0x64,%eax
 805:	0f 84 05 01 00 00    	je     910 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 80b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 811:	83 f9 70             	cmp    $0x70,%ecx
 814:	74 72                	je     888 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 816:	83 f8 73             	cmp    $0x73,%eax
 819:	0f 84 99 00 00 00    	je     8b8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 81f:	83 f8 63             	cmp    $0x63,%eax
 822:	0f 84 08 01 00 00    	je     930 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 828:	83 f8 25             	cmp    $0x25,%eax
 82b:	0f 84 ef 00 00 00    	je     920 <printf+0x180>
  write(fd, &c, 1);
 831:	8d 45 e7             	lea    -0x19(%ebp),%eax
 834:	83 ec 04             	sub    $0x4,%esp
 837:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 83b:	6a 01                	push   $0x1
 83d:	50                   	push   %eax
 83e:	ff 75 08             	pushl  0x8(%ebp)
 841:	e8 dc fd ff ff       	call   622 <write>
 846:	83 c4 0c             	add    $0xc,%esp
 849:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 84c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 84f:	6a 01                	push   $0x1
 851:	50                   	push   %eax
 852:	ff 75 08             	pushl  0x8(%ebp)
 855:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 858:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 85a:	e8 c3 fd ff ff       	call   622 <write>
  for(i = 0; fmt[i]; i++){
 85f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 863:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 866:	84 db                	test   %bl,%bl
 868:	75 89                	jne    7f3 <printf+0x53>
    }
  }
}
 86a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 86d:	5b                   	pop    %ebx
 86e:	5e                   	pop    %esi
 86f:	5f                   	pop    %edi
 870:	5d                   	pop    %ebp
 871:	c3                   	ret    
 872:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 878:	bf 25 00 00 00       	mov    $0x25,%edi
 87d:	e9 66 ff ff ff       	jmp    7e8 <printf+0x48>
 882:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 888:	83 ec 0c             	sub    $0xc,%esp
 88b:	b9 10 00 00 00       	mov    $0x10,%ecx
 890:	6a 00                	push   $0x0
 892:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 895:	8b 45 08             	mov    0x8(%ebp),%eax
 898:	8b 17                	mov    (%edi),%edx
 89a:	e8 61 fe ff ff       	call   700 <printint>
        ap++;
 89f:	89 f8                	mov    %edi,%eax
 8a1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 8a4:	31 ff                	xor    %edi,%edi
        ap++;
 8a6:	83 c0 04             	add    $0x4,%eax
 8a9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 8ac:	e9 37 ff ff ff       	jmp    7e8 <printf+0x48>
 8b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 8b8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 8bb:	8b 08                	mov    (%eax),%ecx
        ap++;
 8bd:	83 c0 04             	add    $0x4,%eax
 8c0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 8c3:	85 c9                	test   %ecx,%ecx
 8c5:	0f 84 8e 00 00 00    	je     959 <printf+0x1b9>
        while(*s != 0){
 8cb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 8ce:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 8d0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 8d2:	84 c0                	test   %al,%al
 8d4:	0f 84 0e ff ff ff    	je     7e8 <printf+0x48>
 8da:	89 75 d0             	mov    %esi,-0x30(%ebp)
 8dd:	89 de                	mov    %ebx,%esi
 8df:	8b 5d 08             	mov    0x8(%ebp),%ebx
 8e2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 8e5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 8e8:	83 ec 04             	sub    $0x4,%esp
          s++;
 8eb:	83 c6 01             	add    $0x1,%esi
 8ee:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 8f1:	6a 01                	push   $0x1
 8f3:	57                   	push   %edi
 8f4:	53                   	push   %ebx
 8f5:	e8 28 fd ff ff       	call   622 <write>
        while(*s != 0){
 8fa:	0f b6 06             	movzbl (%esi),%eax
 8fd:	83 c4 10             	add    $0x10,%esp
 900:	84 c0                	test   %al,%al
 902:	75 e4                	jne    8e8 <printf+0x148>
 904:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 907:	31 ff                	xor    %edi,%edi
 909:	e9 da fe ff ff       	jmp    7e8 <printf+0x48>
 90e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 910:	83 ec 0c             	sub    $0xc,%esp
 913:	b9 0a 00 00 00       	mov    $0xa,%ecx
 918:	6a 01                	push   $0x1
 91a:	e9 73 ff ff ff       	jmp    892 <printf+0xf2>
 91f:	90                   	nop
  write(fd, &c, 1);
 920:	83 ec 04             	sub    $0x4,%esp
 923:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 926:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 929:	6a 01                	push   $0x1
 92b:	e9 21 ff ff ff       	jmp    851 <printf+0xb1>
        putc(fd, *ap);
 930:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 933:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 936:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 938:	6a 01                	push   $0x1
        ap++;
 93a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 93d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 940:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 943:	50                   	push   %eax
 944:	ff 75 08             	pushl  0x8(%ebp)
 947:	e8 d6 fc ff ff       	call   622 <write>
        ap++;
 94c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 94f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 952:	31 ff                	xor    %edi,%edi
 954:	e9 8f fe ff ff       	jmp    7e8 <printf+0x48>
          s = "(null)";
 959:	bb 4f 0b 00 00       	mov    $0xb4f,%ebx
        while(*s != 0){
 95e:	b8 28 00 00 00       	mov    $0x28,%eax
 963:	e9 72 ff ff ff       	jmp    8da <printf+0x13a>
 968:	66 90                	xchg   %ax,%ax
 96a:	66 90                	xchg   %ax,%ax
 96c:	66 90                	xchg   %ax,%ax
 96e:	66 90                	xchg   %ax,%ax

00000970 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 970:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 971:	a1 b0 0e 00 00       	mov    0xeb0,%eax
{
 976:	89 e5                	mov    %esp,%ebp
 978:	57                   	push   %edi
 979:	56                   	push   %esi
 97a:	53                   	push   %ebx
 97b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 97e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 981:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 988:	39 c8                	cmp    %ecx,%eax
 98a:	8b 10                	mov    (%eax),%edx
 98c:	73 32                	jae    9c0 <free+0x50>
 98e:	39 d1                	cmp    %edx,%ecx
 990:	72 04                	jb     996 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 992:	39 d0                	cmp    %edx,%eax
 994:	72 32                	jb     9c8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 996:	8b 73 fc             	mov    -0x4(%ebx),%esi
 999:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 99c:	39 fa                	cmp    %edi,%edx
 99e:	74 30                	je     9d0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 9a0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9a3:	8b 50 04             	mov    0x4(%eax),%edx
 9a6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9a9:	39 f1                	cmp    %esi,%ecx
 9ab:	74 3a                	je     9e7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 9ad:	89 08                	mov    %ecx,(%eax)
  freep = p;
 9af:	a3 b0 0e 00 00       	mov    %eax,0xeb0
}
 9b4:	5b                   	pop    %ebx
 9b5:	5e                   	pop    %esi
 9b6:	5f                   	pop    %edi
 9b7:	5d                   	pop    %ebp
 9b8:	c3                   	ret    
 9b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c0:	39 d0                	cmp    %edx,%eax
 9c2:	72 04                	jb     9c8 <free+0x58>
 9c4:	39 d1                	cmp    %edx,%ecx
 9c6:	72 ce                	jb     996 <free+0x26>
{
 9c8:	89 d0                	mov    %edx,%eax
 9ca:	eb bc                	jmp    988 <free+0x18>
 9cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 9d0:	03 72 04             	add    0x4(%edx),%esi
 9d3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 9d6:	8b 10                	mov    (%eax),%edx
 9d8:	8b 12                	mov    (%edx),%edx
 9da:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9dd:	8b 50 04             	mov    0x4(%eax),%edx
 9e0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9e3:	39 f1                	cmp    %esi,%ecx
 9e5:	75 c6                	jne    9ad <free+0x3d>
    p->s.size += bp->s.size;
 9e7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 9ea:	a3 b0 0e 00 00       	mov    %eax,0xeb0
    p->s.size += bp->s.size;
 9ef:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 9f2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 9f5:	89 10                	mov    %edx,(%eax)
}
 9f7:	5b                   	pop    %ebx
 9f8:	5e                   	pop    %esi
 9f9:	5f                   	pop    %edi
 9fa:	5d                   	pop    %ebp
 9fb:	c3                   	ret    
 9fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a00 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a00:	55                   	push   %ebp
 a01:	89 e5                	mov    %esp,%ebp
 a03:	57                   	push   %edi
 a04:	56                   	push   %esi
 a05:	53                   	push   %ebx
 a06:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a09:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a0c:	8b 15 b0 0e 00 00    	mov    0xeb0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a12:	8d 78 07             	lea    0x7(%eax),%edi
 a15:	c1 ef 03             	shr    $0x3,%edi
 a18:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a1b:	85 d2                	test   %edx,%edx
 a1d:	0f 84 9d 00 00 00    	je     ac0 <malloc+0xc0>
 a23:	8b 02                	mov    (%edx),%eax
 a25:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a28:	39 cf                	cmp    %ecx,%edi
 a2a:	76 6c                	jbe    a98 <malloc+0x98>
 a2c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 a32:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a37:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a3a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a41:	eb 0e                	jmp    a51 <malloc+0x51>
 a43:	90                   	nop
 a44:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a48:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a4a:	8b 48 04             	mov    0x4(%eax),%ecx
 a4d:	39 f9                	cmp    %edi,%ecx
 a4f:	73 47                	jae    a98 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a51:	39 05 b0 0e 00 00    	cmp    %eax,0xeb0
 a57:	89 c2                	mov    %eax,%edx
 a59:	75 ed                	jne    a48 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 a5b:	83 ec 0c             	sub    $0xc,%esp
 a5e:	56                   	push   %esi
 a5f:	e8 26 fc ff ff       	call   68a <sbrk>
  if(p == (char*)-1)
 a64:	83 c4 10             	add    $0x10,%esp
 a67:	83 f8 ff             	cmp    $0xffffffff,%eax
 a6a:	74 1c                	je     a88 <malloc+0x88>
  hp->s.size = nu;
 a6c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a6f:	83 ec 0c             	sub    $0xc,%esp
 a72:	83 c0 08             	add    $0x8,%eax
 a75:	50                   	push   %eax
 a76:	e8 f5 fe ff ff       	call   970 <free>
  return freep;
 a7b:	8b 15 b0 0e 00 00    	mov    0xeb0,%edx
      if((p = morecore(nunits)) == 0)
 a81:	83 c4 10             	add    $0x10,%esp
 a84:	85 d2                	test   %edx,%edx
 a86:	75 c0                	jne    a48 <malloc+0x48>
        return 0;
  }
}
 a88:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 a8b:	31 c0                	xor    %eax,%eax
}
 a8d:	5b                   	pop    %ebx
 a8e:	5e                   	pop    %esi
 a8f:	5f                   	pop    %edi
 a90:	5d                   	pop    %ebp
 a91:	c3                   	ret    
 a92:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 a98:	39 cf                	cmp    %ecx,%edi
 a9a:	74 54                	je     af0 <malloc+0xf0>
        p->s.size -= nunits;
 a9c:	29 f9                	sub    %edi,%ecx
 a9e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 aa1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 aa4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 aa7:	89 15 b0 0e 00 00    	mov    %edx,0xeb0
}
 aad:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 ab0:	83 c0 08             	add    $0x8,%eax
}
 ab3:	5b                   	pop    %ebx
 ab4:	5e                   	pop    %esi
 ab5:	5f                   	pop    %edi
 ab6:	5d                   	pop    %ebp
 ab7:	c3                   	ret    
 ab8:	90                   	nop
 ab9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 ac0:	c7 05 b0 0e 00 00 b4 	movl   $0xeb4,0xeb0
 ac7:	0e 00 00 
 aca:	c7 05 b4 0e 00 00 b4 	movl   $0xeb4,0xeb4
 ad1:	0e 00 00 
    base.s.size = 0;
 ad4:	b8 b4 0e 00 00       	mov    $0xeb4,%eax
 ad9:	c7 05 b8 0e 00 00 00 	movl   $0x0,0xeb8
 ae0:	00 00 00 
 ae3:	e9 44 ff ff ff       	jmp    a2c <malloc+0x2c>
 ae8:	90                   	nop
 ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 af0:	8b 08                	mov    (%eax),%ecx
 af2:	89 0a                	mov    %ecx,(%edx)
 af4:	eb b1                	jmp    aa7 <malloc+0xa7>
