
_assig1_2:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fcntl.h"
#include "ls.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  // int size=20;
  // short arr[size];
  // char c;
  int pid;
  pid = fork();
   f:	e8 4a 06 00 00       	call   65e <fork>
  if (pid==0){
  14:	85 c0                	test   %eax,%eax
  16:	75 3f                	jne    57 <main+0x57>
		create_container(2);
  18:	83 ec 0c             	sub    $0xc,%esp
  1b:	6a 02                	push   $0x2
  1d:	e8 fc 06 00 00       	call   71e <create_container>
		join_container(2);
  22:	c7 04 24 02 00 00 00 	movl   $0x2,(%esp)
  29:	e8 00 07 00 00       	call   72e <join_container>
		// // ps();
    // // char* s = "Rahul";
    int fd2 = open("newfile",0);
  2e:	58                   	pop    %eax
  2f:	5a                   	pop    %edx
  30:	6a 00                	push   $0x0
  32:	68 58 0b 00 00       	push   $0xb58
  37:	e8 6a 06 00 00       	call   6a6 <open>
  3c:	89 c3                	mov    %eax,%ebx
    // // write(fd2,s,5);
    ls(".");
  3e:	c7 04 24 60 0b 00 00 	movl   $0xb60,(%esp)
  45:	e8 86 03 00 00       	call   3d0 <ls>
    close(fd2);
  4a:	89 1c 24             	mov    %ebx,(%esp)
  4d:	e8 3c 06 00 00       	call   68e <close>
    // char* s2 = (char*)malloc(5);
    // read(fd3,s2,5);
    // printf(1,"%s",s2);
    // close(fd3);

		exit();
  52:	e8 0f 06 00 00       	call   666 <exit>
	}
	else{
		exit();
  57:	e8 0a 06 00 00       	call   666 <exit>
  5c:	66 90                	xchg   %ax,%ax
  5e:	66 90                	xchg   %ax,%ax

00000060 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 45 08             	mov    0x8(%ebp),%eax
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  6a:	89 c2                	mov    %eax,%edx
  6c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  70:	83 c1 01             	add    $0x1,%ecx
  73:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  77:	83 c2 01             	add    $0x1,%edx
  7a:	84 db                	test   %bl,%bl
  7c:	88 5a ff             	mov    %bl,-0x1(%edx)
  7f:	75 ef                	jne    70 <strcpy+0x10>
    ;
  return os;
}
  81:	5b                   	pop    %ebx
  82:	5d                   	pop    %ebp
  83:	c3                   	ret    
  84:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  8a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000090 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 55 08             	mov    0x8(%ebp),%edx
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  9a:	0f b6 02             	movzbl (%edx),%eax
  9d:	0f b6 19             	movzbl (%ecx),%ebx
  a0:	84 c0                	test   %al,%al
  a2:	75 1c                	jne    c0 <strcmp+0x30>
  a4:	eb 2a                	jmp    d0 <strcmp+0x40>
  a6:	8d 76 00             	lea    0x0(%esi),%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  b0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  b3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  b6:	83 c1 01             	add    $0x1,%ecx
  b9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  bc:	84 c0                	test   %al,%al
  be:	74 10                	je     d0 <strcmp+0x40>
  c0:	38 d8                	cmp    %bl,%al
  c2:	74 ec                	je     b0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  c4:	29 d8                	sub    %ebx,%eax
}
  c6:	5b                   	pop    %ebx
  c7:	5d                   	pop    %ebp
  c8:	c3                   	ret    
  c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  d0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  d2:	29 d8                	sub    %ebx,%eax
}
  d4:	5b                   	pop    %ebx
  d5:	5d                   	pop    %ebp
  d6:	c3                   	ret    
  d7:	89 f6                	mov    %esi,%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000e0 <strlen>:

uint
strlen(const char *s)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  e6:	80 39 00             	cmpb   $0x0,(%ecx)
  e9:	74 15                	je     100 <strlen+0x20>
  eb:	31 d2                	xor    %edx,%edx
  ed:	8d 76 00             	lea    0x0(%esi),%esi
  f0:	83 c2 01             	add    $0x1,%edx
  f3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  f7:	89 d0                	mov    %edx,%eax
  f9:	75 f5                	jne    f0 <strlen+0x10>
    ;
  return n;
}
  fb:	5d                   	pop    %ebp
  fc:	c3                   	ret    
  fd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 100:	31 c0                	xor    %eax,%eax
}
 102:	5d                   	pop    %ebp
 103:	c3                   	ret    
 104:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 10a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000110 <memset>:

void*
memset(void *dst, int c, uint n)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	57                   	push   %edi
 114:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 117:	8b 4d 10             	mov    0x10(%ebp),%ecx
 11a:	8b 45 0c             	mov    0xc(%ebp),%eax
 11d:	89 d7                	mov    %edx,%edi
 11f:	fc                   	cld    
 120:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 122:	89 d0                	mov    %edx,%eax
 124:	5f                   	pop    %edi
 125:	5d                   	pop    %ebp
 126:	c3                   	ret    
 127:	89 f6                	mov    %esi,%esi
 129:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000130 <strchr>:

char*
strchr(const char *s, char c)
{
 130:	55                   	push   %ebp
 131:	89 e5                	mov    %esp,%ebp
 133:	53                   	push   %ebx
 134:	8b 45 08             	mov    0x8(%ebp),%eax
 137:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 13a:	0f b6 10             	movzbl (%eax),%edx
 13d:	84 d2                	test   %dl,%dl
 13f:	74 1d                	je     15e <strchr+0x2e>
    if(*s == c)
 141:	38 d3                	cmp    %dl,%bl
 143:	89 d9                	mov    %ebx,%ecx
 145:	75 0d                	jne    154 <strchr+0x24>
 147:	eb 17                	jmp    160 <strchr+0x30>
 149:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 150:	38 ca                	cmp    %cl,%dl
 152:	74 0c                	je     160 <strchr+0x30>
  for(; *s; s++)
 154:	83 c0 01             	add    $0x1,%eax
 157:	0f b6 10             	movzbl (%eax),%edx
 15a:	84 d2                	test   %dl,%dl
 15c:	75 f2                	jne    150 <strchr+0x20>
      return (char*)s;
  return 0;
 15e:	31 c0                	xor    %eax,%eax
}
 160:	5b                   	pop    %ebx
 161:	5d                   	pop    %ebp
 162:	c3                   	ret    
 163:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <gets>:

char*
gets(char *buf, int max)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	57                   	push   %edi
 174:	56                   	push   %esi
 175:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 176:	31 f6                	xor    %esi,%esi
 178:	89 f3                	mov    %esi,%ebx
{
 17a:	83 ec 1c             	sub    $0x1c,%esp
 17d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 180:	eb 2f                	jmp    1b1 <gets+0x41>
 182:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 188:	8d 45 e7             	lea    -0x19(%ebp),%eax
 18b:	83 ec 04             	sub    $0x4,%esp
 18e:	6a 01                	push   $0x1
 190:	50                   	push   %eax
 191:	6a 00                	push   $0x0
 193:	e8 e6 04 00 00       	call   67e <read>
    if(cc < 1)
 198:	83 c4 10             	add    $0x10,%esp
 19b:	85 c0                	test   %eax,%eax
 19d:	7e 1c                	jle    1bb <gets+0x4b>
      break;
    buf[i++] = c;
 19f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1a3:	83 c7 01             	add    $0x1,%edi
 1a6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1a9:	3c 0a                	cmp    $0xa,%al
 1ab:	74 23                	je     1d0 <gets+0x60>
 1ad:	3c 0d                	cmp    $0xd,%al
 1af:	74 1f                	je     1d0 <gets+0x60>
  for(i=0; i+1 < max; ){
 1b1:	83 c3 01             	add    $0x1,%ebx
 1b4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1b7:	89 fe                	mov    %edi,%esi
 1b9:	7c cd                	jl     188 <gets+0x18>
 1bb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1bd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1c0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1c3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1c6:	5b                   	pop    %ebx
 1c7:	5e                   	pop    %esi
 1c8:	5f                   	pop    %edi
 1c9:	5d                   	pop    %ebp
 1ca:	c3                   	ret    
 1cb:	90                   	nop
 1cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1d0:	8b 75 08             	mov    0x8(%ebp),%esi
 1d3:	8b 45 08             	mov    0x8(%ebp),%eax
 1d6:	01 de                	add    %ebx,%esi
 1d8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1da:	c6 03 00             	movb   $0x0,(%ebx)
}
 1dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1e0:	5b                   	pop    %ebx
 1e1:	5e                   	pop    %esi
 1e2:	5f                   	pop    %edi
 1e3:	5d                   	pop    %ebp
 1e4:	c3                   	ret    
 1e5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001f0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	56                   	push   %esi
 1f4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1f5:	83 ec 08             	sub    $0x8,%esp
 1f8:	6a 00                	push   $0x0
 1fa:	ff 75 08             	pushl  0x8(%ebp)
 1fd:	e8 a4 04 00 00       	call   6a6 <open>
  if(fd < 0)
 202:	83 c4 10             	add    $0x10,%esp
 205:	85 c0                	test   %eax,%eax
 207:	78 27                	js     230 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 209:	83 ec 08             	sub    $0x8,%esp
 20c:	ff 75 0c             	pushl  0xc(%ebp)
 20f:	89 c3                	mov    %eax,%ebx
 211:	50                   	push   %eax
 212:	e8 a7 04 00 00       	call   6be <fstat>
  close(fd);
 217:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 21a:	89 c6                	mov    %eax,%esi
  close(fd);
 21c:	e8 6d 04 00 00       	call   68e <close>
  return r;
 221:	83 c4 10             	add    $0x10,%esp
}
 224:	8d 65 f8             	lea    -0x8(%ebp),%esp
 227:	89 f0                	mov    %esi,%eax
 229:	5b                   	pop    %ebx
 22a:	5e                   	pop    %esi
 22b:	5d                   	pop    %ebp
 22c:	c3                   	ret    
 22d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 230:	be ff ff ff ff       	mov    $0xffffffff,%esi
 235:	eb ed                	jmp    224 <stat+0x34>
 237:	89 f6                	mov    %esi,%esi
 239:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000240 <atoi>:

int
atoi(const char *s)
{
 240:	55                   	push   %ebp
 241:	89 e5                	mov    %esp,%ebp
 243:	53                   	push   %ebx
 244:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 247:	0f be 11             	movsbl (%ecx),%edx
 24a:	8d 42 d0             	lea    -0x30(%edx),%eax
 24d:	3c 09                	cmp    $0x9,%al
  n = 0;
 24f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 254:	77 1f                	ja     275 <atoi+0x35>
 256:	8d 76 00             	lea    0x0(%esi),%esi
 259:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 260:	8d 04 80             	lea    (%eax,%eax,4),%eax
 263:	83 c1 01             	add    $0x1,%ecx
 266:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 26a:	0f be 11             	movsbl (%ecx),%edx
 26d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 270:	80 fb 09             	cmp    $0x9,%bl
 273:	76 eb                	jbe    260 <atoi+0x20>
  return n;
}
 275:	5b                   	pop    %ebx
 276:	5d                   	pop    %ebp
 277:	c3                   	ret    
 278:	90                   	nop
 279:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000280 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
 285:	8b 5d 10             	mov    0x10(%ebp),%ebx
 288:	8b 45 08             	mov    0x8(%ebp),%eax
 28b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 28e:	85 db                	test   %ebx,%ebx
 290:	7e 14                	jle    2a6 <memmove+0x26>
 292:	31 d2                	xor    %edx,%edx
 294:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 298:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 29c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 29f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2a2:	39 d3                	cmp    %edx,%ebx
 2a4:	75 f2                	jne    298 <memmove+0x18>
  return vdst;
}
 2a6:	5b                   	pop    %ebx
 2a7:	5e                   	pop    %esi
 2a8:	5d                   	pop    %ebp
 2a9:	c3                   	ret    
 2aa:	66 90                	xchg   %ax,%ax
 2ac:	66 90                	xchg   %ax,%ax
 2ae:	66 90                	xchg   %ax,%ax

000002b0 <mystrcmp>:
#include "ls.h"
// #include "defs.h"

int
mystrcmp (char *s1, char *s2)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	53                   	push   %ebx
 2b5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int a =0,b=0;
 2b8:	31 db                	xor    %ebx,%ebx
{
 2ba:	8b 55 0c             	mov    0xc(%ebp),%edx
    while(*s1){a++;s1++;}
 2bd:	80 39 00             	cmpb   $0x0,(%ecx)
 2c0:	0f b6 02             	movzbl (%edx),%eax
 2c3:	74 33                	je     2f8 <mystrcmp+0x48>
 2c5:	8d 76 00             	lea    0x0(%esi),%esi
 2c8:	83 c1 01             	add    $0x1,%ecx
 2cb:	83 c3 01             	add    $0x1,%ebx
 2ce:	80 39 00             	cmpb   $0x0,(%ecx)
 2d1:	75 f5                	jne    2c8 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
 2d3:	84 c0                	test   %al,%al
 2d5:	74 51                	je     328 <mystrcmp+0x78>
    int a =0,b=0;
 2d7:	31 f6                	xor    %esi,%esi
 2d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
 2e0:	83 c2 01             	add    $0x1,%edx
 2e3:	83 c6 01             	add    $0x1,%esi
 2e6:	80 3a 00             	cmpb   $0x0,(%edx)
 2e9:	75 f5                	jne    2e0 <mystrcmp+0x30>

    if(a!=b)return 0;
 2eb:	31 c0                	xor    %eax,%eax
 2ed:	39 de                	cmp    %ebx,%esi
 2ef:	74 0f                	je     300 <mystrcmp+0x50>
    // printf("here");
    while(a--){
        if(*s1++ != *s2++)return 0;
    }
    return 1;
}
 2f1:	5b                   	pop    %ebx
 2f2:	5e                   	pop    %esi
 2f3:	5d                   	pop    %ebp
 2f4:	c3                   	ret    
 2f5:	8d 76 00             	lea    0x0(%esi),%esi
    while(*s2){b++;s2++;}
 2f8:	84 c0                	test   %al,%al
 2fa:	75 db                	jne    2d7 <mystrcmp+0x27>
 2fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 300:	01 d3                	add    %edx,%ebx
 302:	eb 13                	jmp    317 <mystrcmp+0x67>
 304:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(*s1++ != *s2++)return 0;
 308:	83 c2 01             	add    $0x1,%edx
 30b:	83 c1 01             	add    $0x1,%ecx
 30e:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
 312:	38 41 ff             	cmp    %al,-0x1(%ecx)
 315:	75 11                	jne    328 <mystrcmp+0x78>
    while(a--){
 317:	39 d3                	cmp    %edx,%ebx
 319:	75 ed                	jne    308 <mystrcmp+0x58>
}
 31b:	5b                   	pop    %ebx
    return 1;
 31c:	b8 01 00 00 00       	mov    $0x1,%eax
}
 321:	5e                   	pop    %esi
 322:	5d                   	pop    %ebp
 323:	c3                   	ret    
 324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 328:	5b                   	pop    %ebx
    if(a!=b)return 0;
 329:	31 c0                	xor    %eax,%eax
}
 32b:	5e                   	pop    %esi
 32c:	5d                   	pop    %ebp
 32d:	c3                   	ret    
 32e:	66 90                	xchg   %ax,%ax

00000330 <fmtname>:

char*
fmtname(char *path)
{
 330:	55                   	push   %ebp
 331:	89 e5                	mov    %esp,%ebp
 333:	56                   	push   %esi
 334:	53                   	push   %ebx
 335:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
 338:	83 ec 0c             	sub    $0xc,%esp
 33b:	53                   	push   %ebx
 33c:	e8 9f fd ff ff       	call   e0 <strlen>
 341:	83 c4 10             	add    $0x10,%esp
 344:	01 d8                	add    %ebx,%eax
 346:	73 0f                	jae    357 <fmtname+0x27>
 348:	eb 12                	jmp    35c <fmtname+0x2c>
 34a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 350:	83 e8 01             	sub    $0x1,%eax
 353:	39 c3                	cmp    %eax,%ebx
 355:	77 05                	ja     35c <fmtname+0x2c>
 357:	80 38 2f             	cmpb   $0x2f,(%eax)
 35a:	75 f4                	jne    350 <fmtname+0x20>
    ;
  p++;
 35c:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
 35f:	83 ec 0c             	sub    $0xc,%esp
 362:	53                   	push   %ebx
 363:	e8 78 fd ff ff       	call   e0 <strlen>
 368:	83 c4 10             	add    $0x10,%esp
 36b:	83 f8 0d             	cmp    $0xd,%eax
 36e:	77 4a                	ja     3ba <fmtname+0x8a>
    return p;
  memmove(buf, p, strlen(p));
 370:	83 ec 0c             	sub    $0xc,%esp
 373:	53                   	push   %ebx
 374:	e8 67 fd ff ff       	call   e0 <strlen>
 379:	83 c4 0c             	add    $0xc,%esp
 37c:	50                   	push   %eax
 37d:	53                   	push   %ebx
 37e:	68 20 0f 00 00       	push   $0xf20
 383:	e8 f8 fe ff ff       	call   280 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 388:	89 1c 24             	mov    %ebx,(%esp)
 38b:	e8 50 fd ff ff       	call   e0 <strlen>
 390:	89 1c 24             	mov    %ebx,(%esp)
 393:	89 c6                	mov    %eax,%esi
  return buf;
 395:	bb 20 0f 00 00       	mov    $0xf20,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 39a:	e8 41 fd ff ff       	call   e0 <strlen>
 39f:	ba 0e 00 00 00       	mov    $0xe,%edx
 3a4:	83 c4 0c             	add    $0xc,%esp
 3a7:	05 20 0f 00 00       	add    $0xf20,%eax
 3ac:	29 f2                	sub    %esi,%edx
 3ae:	52                   	push   %edx
 3af:	6a 20                	push   $0x20
 3b1:	50                   	push   %eax
 3b2:	e8 59 fd ff ff       	call   110 <memset>
  return buf;
 3b7:	83 c4 10             	add    $0x10,%esp
}
 3ba:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3bd:	89 d8                	mov    %ebx,%eax
 3bf:	5b                   	pop    %ebx
 3c0:	5e                   	pop    %esi
 3c1:	5d                   	pop    %ebp
 3c2:	c3                   	ret    
 3c3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003d0 <ls>:

void
ls(char *path)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	57                   	push   %edi
 3d4:	56                   	push   %esi
 3d5:	53                   	push   %ebx
 3d6:	81 ec 5c 02 00 00    	sub    $0x25c,%esp

  int cid = getcid();
 3dc:	e8 6d 03 00 00       	call   74e <getcid>

  printf(2, "Cid is: %d\n", cid);
 3e1:	83 ec 04             	sub    $0x4,%esp
  int cid = getcid();
 3e4:	89 c7                	mov    %eax,%edi
  printf(2, "Cid is: %d\n", cid);
 3e6:	50                   	push   %eax
 3e7:	68 62 0b 00 00       	push   $0xb62
 3ec:	6a 02                	push   $0x2
 3ee:	e8 0d 04 00 00       	call   800 <printf>
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  if((fd = open(path, 0)) < 0){
 3f3:	59                   	pop    %ecx
 3f4:	5b                   	pop    %ebx
 3f5:	6a 00                	push   $0x0
 3f7:	ff 75 08             	pushl  0x8(%ebp)
 3fa:	e8 a7 02 00 00       	call   6a6 <open>
 3ff:	83 c4 10             	add    $0x10,%esp
 402:	85 c0                	test   %eax,%eax
 404:	78 5a                	js     460 <ls+0x90>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 406:	8d b5 d0 fd ff ff    	lea    -0x230(%ebp),%esi
 40c:	83 ec 08             	sub    $0x8,%esp
 40f:	89 c3                	mov    %eax,%ebx
 411:	56                   	push   %esi
 412:	50                   	push   %eax
 413:	e8 a6 02 00 00       	call   6be <fstat>
 418:	83 c4 10             	add    $0x10,%esp
 41b:	85 c0                	test   %eax,%eax
 41d:	0f 88 cd 00 00 00    	js     4f0 <ls+0x120>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  switch(st.type){
 423:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 42a:	66 83 f8 01          	cmp    $0x1,%ax
 42e:	74 50                	je     480 <ls+0xb0>
 430:	66 83 f8 02          	cmp    $0x2,%ax
 434:	75 12                	jne    448 <ls+0x78>
  case T_FILE:
    if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 436:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 43c:	8d 42 01             	lea    0x1(%edx),%eax
 43f:	83 f8 01             	cmp    $0x1,%eax
 442:	76 6c                	jbe    4b0 <ls+0xe0>
 444:	39 fa                	cmp    %edi,%edx
 446:	74 68                	je     4b0 <ls+0xe0>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
    }
    break;
  }
  close(fd);
 448:	83 ec 0c             	sub    $0xc,%esp
 44b:	53                   	push   %ebx
 44c:	e8 3d 02 00 00       	call   68e <close>
 451:	83 c4 10             	add    $0x10,%esp

}
 454:	8d 65 f4             	lea    -0xc(%ebp),%esp
 457:	5b                   	pop    %ebx
 458:	5e                   	pop    %esi
 459:	5f                   	pop    %edi
 45a:	5d                   	pop    %ebp
 45b:	c3                   	ret    
 45c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
 460:	83 ec 04             	sub    $0x4,%esp
 463:	ff 75 08             	pushl  0x8(%ebp)
 466:	68 6e 0b 00 00       	push   $0xb6e
 46b:	6a 02                	push   $0x2
 46d:	e8 8e 03 00 00       	call   800 <printf>
    return;
 472:	83 c4 10             	add    $0x10,%esp
}
 475:	8d 65 f4             	lea    -0xc(%ebp),%esp
 478:	5b                   	pop    %ebx
 479:	5e                   	pop    %esi
 47a:	5f                   	pop    %edi
 47b:	5d                   	pop    %ebp
 47c:	c3                   	ret    
 47d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 480:	83 ec 0c             	sub    $0xc,%esp
 483:	ff 75 08             	pushl  0x8(%ebp)
 486:	e8 55 fc ff ff       	call   e0 <strlen>
 48b:	83 c0 10             	add    $0x10,%eax
 48e:	83 c4 10             	add    $0x10,%esp
 491:	3d 00 02 00 00       	cmp    $0x200,%eax
 496:	0f 86 7c 00 00 00    	jbe    518 <ls+0x148>
      printf(1, "ls: path too long\n");
 49c:	83 ec 08             	sub    $0x8,%esp
 49f:	68 a6 0b 00 00       	push   $0xba6
 4a4:	6a 01                	push   $0x1
 4a6:	e8 55 03 00 00       	call   800 <printf>
      break;
 4ab:	83 c4 10             	add    $0x10,%esp
 4ae:	eb 98                	jmp    448 <ls+0x78>
    printf(1, "%s %d %d %d %d\n", fmtname(path), st.type, st.ino, st.size, st.cid);
 4b0:	83 ec 0c             	sub    $0xc,%esp
 4b3:	ff 75 08             	pushl  0x8(%ebp)
 4b6:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 4bc:	8b bd e0 fd ff ff    	mov    -0x220(%ebp),%edi
 4c2:	8b b5 d8 fd ff ff    	mov    -0x228(%ebp),%esi
 4c8:	e8 63 fe ff ff       	call   330 <fmtname>
 4cd:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 4d3:	83 c4 0c             	add    $0xc,%esp
 4d6:	52                   	push   %edx
 4d7:	57                   	push   %edi
 4d8:	56                   	push   %esi
 4d9:	6a 02                	push   $0x2
 4db:	50                   	push   %eax
 4dc:	68 96 0b 00 00       	push   $0xb96
 4e1:	6a 01                	push   $0x1
 4e3:	e8 18 03 00 00       	call   800 <printf>
    break;
 4e8:	83 c4 20             	add    $0x20,%esp
 4eb:	e9 58 ff ff ff       	jmp    448 <ls+0x78>
    printf(2, "ls: cannot stat %s\n", path);
 4f0:	83 ec 04             	sub    $0x4,%esp
 4f3:	ff 75 08             	pushl  0x8(%ebp)
 4f6:	68 82 0b 00 00       	push   $0xb82
 4fb:	6a 02                	push   $0x2
 4fd:	e8 fe 02 00 00       	call   800 <printf>
    close(fd);
 502:	89 1c 24             	mov    %ebx,(%esp)
 505:	e8 84 01 00 00       	call   68e <close>
    return;
 50a:	83 c4 10             	add    $0x10,%esp
}
 50d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 510:	5b                   	pop    %ebx
 511:	5e                   	pop    %esi
 512:	5f                   	pop    %edi
 513:	5d                   	pop    %ebp
 514:	c3                   	ret    
 515:	8d 76 00             	lea    0x0(%esi),%esi
    strcpy(buf, path);
 518:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 51e:	83 ec 08             	sub    $0x8,%esp
 521:	ff 75 08             	pushl  0x8(%ebp)
 524:	50                   	push   %eax
 525:	e8 36 fb ff ff       	call   60 <strcpy>
    p = buf+strlen(buf);
 52a:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 530:	89 04 24             	mov    %eax,(%esp)
 533:	e8 a8 fb ff ff       	call   e0 <strlen>
 538:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 53e:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 541:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 543:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 546:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 54c:	c6 00 2f             	movb   $0x2f,(%eax)
 54f:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 555:	8d 76 00             	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 558:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
 55e:	83 ec 04             	sub    $0x4,%esp
 561:	6a 10                	push   $0x10
 563:	50                   	push   %eax
 564:	53                   	push   %ebx
 565:	e8 14 01 00 00       	call   67e <read>
 56a:	83 c4 10             	add    $0x10,%esp
 56d:	83 f8 10             	cmp    $0x10,%eax
 570:	0f 85 d2 fe ff ff    	jne    448 <ls+0x78>
      if(de.inum == 0)
 576:	66 83 bd c0 fd ff ff 	cmpw   $0x0,-0x240(%ebp)
 57d:	00 
 57e:	74 d8                	je     558 <ls+0x188>
      memmove(p, de.name, DIRSIZ);
 580:	8d 85 c2 fd ff ff    	lea    -0x23e(%ebp),%eax
 586:	83 ec 04             	sub    $0x4,%esp
 589:	6a 0e                	push   $0xe
 58b:	50                   	push   %eax
 58c:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 592:	e8 e9 fc ff ff       	call   280 <memmove>
      p[DIRSIZ] = 0;
 597:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 59d:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 5a1:	58                   	pop    %eax
 5a2:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 5a8:	5a                   	pop    %edx
 5a9:	56                   	push   %esi
 5aa:	50                   	push   %eax
 5ab:	e8 40 fc ff ff       	call   1f0 <stat>
 5b0:	83 c4 10             	add    $0x10,%esp
 5b3:	85 c0                	test   %eax,%eax
 5b5:	0f 88 85 00 00 00    	js     640 <ls+0x270>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 5bb:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 5c1:	8d 42 01             	lea    0x1(%edx),%eax
 5c4:	83 f8 01             	cmp    $0x1,%eax
 5c7:	76 04                	jbe    5cd <ls+0x1fd>
 5c9:	39 fa                	cmp    %edi,%edx
 5cb:	75 8b                	jne    558 <ls+0x188>
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
 5cd:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
 5d3:	89 95 a0 fd ff ff    	mov    %edx,-0x260(%ebp)
 5d9:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 5df:	83 ec 0c             	sub    $0xc,%esp
 5e2:	8b 85 d8 fd ff ff    	mov    -0x228(%ebp),%eax
 5e8:	52                   	push   %edx
 5e9:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 5ef:	0f bf 8d d0 fd ff ff 	movswl -0x230(%ebp),%ecx
 5f6:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 5fc:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 602:	e8 29 fd ff ff       	call   330 <fmtname>
 607:	8b 95 a0 fd ff ff    	mov    -0x260(%ebp),%edx
 60d:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
 613:	83 c4 0c             	add    $0xc,%esp
 616:	52                   	push   %edx
 617:	51                   	push   %ecx
 618:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 61e:	ff b5 a8 fd ff ff    	pushl  -0x258(%ebp)
 624:	50                   	push   %eax
 625:	68 96 0b 00 00       	push   $0xb96
 62a:	6a 01                	push   $0x1
 62c:	e8 cf 01 00 00       	call   800 <printf>
 631:	83 c4 20             	add    $0x20,%esp
 634:	e9 1f ff ff ff       	jmp    558 <ls+0x188>
 639:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 640:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 646:	83 ec 04             	sub    $0x4,%esp
 649:	50                   	push   %eax
 64a:	68 82 0b 00 00       	push   $0xb82
 64f:	6a 01                	push   $0x1
 651:	e8 aa 01 00 00       	call   800 <printf>
        continue;
 656:	83 c4 10             	add    $0x10,%esp
 659:	e9 fa fe ff ff       	jmp    558 <ls+0x188>

0000065e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 65e:	b8 01 00 00 00       	mov    $0x1,%eax
 663:	cd 40                	int    $0x40
 665:	c3                   	ret    

00000666 <exit>:
SYSCALL(exit)
 666:	b8 02 00 00 00       	mov    $0x2,%eax
 66b:	cd 40                	int    $0x40
 66d:	c3                   	ret    

0000066e <wait>:
SYSCALL(wait)
 66e:	b8 03 00 00 00       	mov    $0x3,%eax
 673:	cd 40                	int    $0x40
 675:	c3                   	ret    

00000676 <pipe>:
SYSCALL(pipe)
 676:	b8 04 00 00 00       	mov    $0x4,%eax
 67b:	cd 40                	int    $0x40
 67d:	c3                   	ret    

0000067e <read>:
SYSCALL(read)
 67e:	b8 05 00 00 00       	mov    $0x5,%eax
 683:	cd 40                	int    $0x40
 685:	c3                   	ret    

00000686 <write>:
SYSCALL(write)
 686:	b8 10 00 00 00       	mov    $0x10,%eax
 68b:	cd 40                	int    $0x40
 68d:	c3                   	ret    

0000068e <close>:
SYSCALL(close)
 68e:	b8 15 00 00 00       	mov    $0x15,%eax
 693:	cd 40                	int    $0x40
 695:	c3                   	ret    

00000696 <kill>:
SYSCALL(kill)
 696:	b8 06 00 00 00       	mov    $0x6,%eax
 69b:	cd 40                	int    $0x40
 69d:	c3                   	ret    

0000069e <exec>:
SYSCALL(exec)
 69e:	b8 07 00 00 00       	mov    $0x7,%eax
 6a3:	cd 40                	int    $0x40
 6a5:	c3                   	ret    

000006a6 <open>:
SYSCALL(open)
 6a6:	b8 0f 00 00 00       	mov    $0xf,%eax
 6ab:	cd 40                	int    $0x40
 6ad:	c3                   	ret    

000006ae <mknod>:
SYSCALL(mknod)
 6ae:	b8 11 00 00 00       	mov    $0x11,%eax
 6b3:	cd 40                	int    $0x40
 6b5:	c3                   	ret    

000006b6 <unlink>:
SYSCALL(unlink)
 6b6:	b8 12 00 00 00       	mov    $0x12,%eax
 6bb:	cd 40                	int    $0x40
 6bd:	c3                   	ret    

000006be <fstat>:
SYSCALL(fstat)
 6be:	b8 08 00 00 00       	mov    $0x8,%eax
 6c3:	cd 40                	int    $0x40
 6c5:	c3                   	ret    

000006c6 <link>:
SYSCALL(link)
 6c6:	b8 13 00 00 00       	mov    $0x13,%eax
 6cb:	cd 40                	int    $0x40
 6cd:	c3                   	ret    

000006ce <mkdir>:
SYSCALL(mkdir)
 6ce:	b8 14 00 00 00       	mov    $0x14,%eax
 6d3:	cd 40                	int    $0x40
 6d5:	c3                   	ret    

000006d6 <chdir>:
SYSCALL(chdir)
 6d6:	b8 09 00 00 00       	mov    $0x9,%eax
 6db:	cd 40                	int    $0x40
 6dd:	c3                   	ret    

000006de <dup>:
SYSCALL(dup)
 6de:	b8 0a 00 00 00       	mov    $0xa,%eax
 6e3:	cd 40                	int    $0x40
 6e5:	c3                   	ret    

000006e6 <getpid>:
SYSCALL(getpid)
 6e6:	b8 0b 00 00 00       	mov    $0xb,%eax
 6eb:	cd 40                	int    $0x40
 6ed:	c3                   	ret    

000006ee <sbrk>:
SYSCALL(sbrk)
 6ee:	b8 0c 00 00 00       	mov    $0xc,%eax
 6f3:	cd 40                	int    $0x40
 6f5:	c3                   	ret    

000006f6 <sleep>:
SYSCALL(sleep)
 6f6:	b8 0d 00 00 00       	mov    $0xd,%eax
 6fb:	cd 40                	int    $0x40
 6fd:	c3                   	ret    

000006fe <uptime>:
SYSCALL(uptime)
 6fe:	b8 0e 00 00 00       	mov    $0xe,%eax
 703:	cd 40                	int    $0x40
 705:	c3                   	ret    

00000706 <halt>:
SYSCALL(halt)
 706:	b8 16 00 00 00       	mov    $0x16,%eax
 70b:	cd 40                	int    $0x40
 70d:	c3                   	ret    

0000070e <toggle>:
SYSCALL(toggle)
 70e:	b8 17 00 00 00       	mov    $0x17,%eax
 713:	cd 40                	int    $0x40
 715:	c3                   	ret    

00000716 <ps>:
SYSCALL(ps)
 716:	b8 18 00 00 00       	mov    $0x18,%eax
 71b:	cd 40                	int    $0x40
 71d:	c3                   	ret    

0000071e <create_container>:
SYSCALL(create_container)
 71e:	b8 1c 00 00 00       	mov    $0x1c,%eax
 723:	cd 40                	int    $0x40
 725:	c3                   	ret    

00000726 <destroy_container>:
SYSCALL(destroy_container)
 726:	b8 19 00 00 00       	mov    $0x19,%eax
 72b:	cd 40                	int    $0x40
 72d:	c3                   	ret    

0000072e <join_container>:
SYSCALL(join_container)
 72e:	b8 1a 00 00 00       	mov    $0x1a,%eax
 733:	cd 40                	int    $0x40
 735:	c3                   	ret    

00000736 <leave_container>:
SYSCALL(leave_container)
 736:	b8 1b 00 00 00       	mov    $0x1b,%eax
 73b:	cd 40                	int    $0x40
 73d:	c3                   	ret    

0000073e <send>:
SYSCALL(send)
 73e:	b8 1d 00 00 00       	mov    $0x1d,%eax
 743:	cd 40                	int    $0x40
 745:	c3                   	ret    

00000746 <recv>:
SYSCALL(recv)
 746:	b8 1e 00 00 00       	mov    $0x1e,%eax
 74b:	cd 40                	int    $0x40
 74d:	c3                   	ret    

0000074e <getcid>:
SYSCALL(getcid)
 74e:	b8 1f 00 00 00       	mov    $0x1f,%eax
 753:	cd 40                	int    $0x40
 755:	c3                   	ret    
 756:	66 90                	xchg   %ax,%ax
 758:	66 90                	xchg   %ax,%ax
 75a:	66 90                	xchg   %ax,%ax
 75c:	66 90                	xchg   %ax,%ax
 75e:	66 90                	xchg   %ax,%ax

00000760 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 760:	55                   	push   %ebp
 761:	89 e5                	mov    %esp,%ebp
 763:	57                   	push   %edi
 764:	56                   	push   %esi
 765:	53                   	push   %ebx
 766:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 769:	85 d2                	test   %edx,%edx
{
 76b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 76e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 770:	79 76                	jns    7e8 <printint+0x88>
 772:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 776:	74 70                	je     7e8 <printint+0x88>
    x = -xx;
 778:	f7 d8                	neg    %eax
    neg = 1;
 77a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 781:	31 f6                	xor    %esi,%esi
 783:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 786:	eb 0a                	jmp    792 <printint+0x32>
 788:	90                   	nop
 789:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 790:	89 fe                	mov    %edi,%esi
 792:	31 d2                	xor    %edx,%edx
 794:	8d 7e 01             	lea    0x1(%esi),%edi
 797:	f7 f1                	div    %ecx
 799:	0f b6 92 c0 0b 00 00 	movzbl 0xbc0(%edx),%edx
  }while((x /= base) != 0);
 7a0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 7a2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 7a5:	75 e9                	jne    790 <printint+0x30>
  if(neg)
 7a7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 7aa:	85 c0                	test   %eax,%eax
 7ac:	74 08                	je     7b6 <printint+0x56>
    buf[i++] = '-';
 7ae:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 7b3:	8d 7e 02             	lea    0x2(%esi),%edi
 7b6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 7ba:	8b 7d c0             	mov    -0x40(%ebp),%edi
 7bd:	8d 76 00             	lea    0x0(%esi),%esi
 7c0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 7c3:	83 ec 04             	sub    $0x4,%esp
 7c6:	83 ee 01             	sub    $0x1,%esi
 7c9:	6a 01                	push   $0x1
 7cb:	53                   	push   %ebx
 7cc:	57                   	push   %edi
 7cd:	88 45 d7             	mov    %al,-0x29(%ebp)
 7d0:	e8 b1 fe ff ff       	call   686 <write>

  while(--i >= 0)
 7d5:	83 c4 10             	add    $0x10,%esp
 7d8:	39 de                	cmp    %ebx,%esi
 7da:	75 e4                	jne    7c0 <printint+0x60>
    putc(fd, buf[i]);
}
 7dc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7df:	5b                   	pop    %ebx
 7e0:	5e                   	pop    %esi
 7e1:	5f                   	pop    %edi
 7e2:	5d                   	pop    %ebp
 7e3:	c3                   	ret    
 7e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 7e8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 7ef:	eb 90                	jmp    781 <printint+0x21>
 7f1:	eb 0d                	jmp    800 <printf>
 7f3:	90                   	nop
 7f4:	90                   	nop
 7f5:	90                   	nop
 7f6:	90                   	nop
 7f7:	90                   	nop
 7f8:	90                   	nop
 7f9:	90                   	nop
 7fa:	90                   	nop
 7fb:	90                   	nop
 7fc:	90                   	nop
 7fd:	90                   	nop
 7fe:	90                   	nop
 7ff:	90                   	nop

00000800 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 800:	55                   	push   %ebp
 801:	89 e5                	mov    %esp,%ebp
 803:	57                   	push   %edi
 804:	56                   	push   %esi
 805:	53                   	push   %ebx
 806:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 809:	8b 75 0c             	mov    0xc(%ebp),%esi
 80c:	0f b6 1e             	movzbl (%esi),%ebx
 80f:	84 db                	test   %bl,%bl
 811:	0f 84 b3 00 00 00    	je     8ca <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 817:	8d 45 10             	lea    0x10(%ebp),%eax
 81a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 81d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 81f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 822:	eb 2f                	jmp    853 <printf+0x53>
 824:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 828:	83 f8 25             	cmp    $0x25,%eax
 82b:	0f 84 a7 00 00 00    	je     8d8 <printf+0xd8>
  write(fd, &c, 1);
 831:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 834:	83 ec 04             	sub    $0x4,%esp
 837:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 83a:	6a 01                	push   $0x1
 83c:	50                   	push   %eax
 83d:	ff 75 08             	pushl  0x8(%ebp)
 840:	e8 41 fe ff ff       	call   686 <write>
 845:	83 c4 10             	add    $0x10,%esp
 848:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 84b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 84f:	84 db                	test   %bl,%bl
 851:	74 77                	je     8ca <printf+0xca>
    if(state == 0){
 853:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 855:	0f be cb             	movsbl %bl,%ecx
 858:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 85b:	74 cb                	je     828 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 85d:	83 ff 25             	cmp    $0x25,%edi
 860:	75 e6                	jne    848 <printf+0x48>
      if(c == 'd'){
 862:	83 f8 64             	cmp    $0x64,%eax
 865:	0f 84 05 01 00 00    	je     970 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 86b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 871:	83 f9 70             	cmp    $0x70,%ecx
 874:	74 72                	je     8e8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 876:	83 f8 73             	cmp    $0x73,%eax
 879:	0f 84 99 00 00 00    	je     918 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 87f:	83 f8 63             	cmp    $0x63,%eax
 882:	0f 84 08 01 00 00    	je     990 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 888:	83 f8 25             	cmp    $0x25,%eax
 88b:	0f 84 ef 00 00 00    	je     980 <printf+0x180>
  write(fd, &c, 1);
 891:	8d 45 e7             	lea    -0x19(%ebp),%eax
 894:	83 ec 04             	sub    $0x4,%esp
 897:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 89b:	6a 01                	push   $0x1
 89d:	50                   	push   %eax
 89e:	ff 75 08             	pushl  0x8(%ebp)
 8a1:	e8 e0 fd ff ff       	call   686 <write>
 8a6:	83 c4 0c             	add    $0xc,%esp
 8a9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 8ac:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 8af:	6a 01                	push   $0x1
 8b1:	50                   	push   %eax
 8b2:	ff 75 08             	pushl  0x8(%ebp)
 8b5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8b8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 8ba:	e8 c7 fd ff ff       	call   686 <write>
  for(i = 0; fmt[i]; i++){
 8bf:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 8c3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 8c6:	84 db                	test   %bl,%bl
 8c8:	75 89                	jne    853 <printf+0x53>
    }
  }
}
 8ca:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8cd:	5b                   	pop    %ebx
 8ce:	5e                   	pop    %esi
 8cf:	5f                   	pop    %edi
 8d0:	5d                   	pop    %ebp
 8d1:	c3                   	ret    
 8d2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 8d8:	bf 25 00 00 00       	mov    $0x25,%edi
 8dd:	e9 66 ff ff ff       	jmp    848 <printf+0x48>
 8e2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 8e8:	83 ec 0c             	sub    $0xc,%esp
 8eb:	b9 10 00 00 00       	mov    $0x10,%ecx
 8f0:	6a 00                	push   $0x0
 8f2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 8f5:	8b 45 08             	mov    0x8(%ebp),%eax
 8f8:	8b 17                	mov    (%edi),%edx
 8fa:	e8 61 fe ff ff       	call   760 <printint>
        ap++;
 8ff:	89 f8                	mov    %edi,%eax
 901:	83 c4 10             	add    $0x10,%esp
      state = 0;
 904:	31 ff                	xor    %edi,%edi
        ap++;
 906:	83 c0 04             	add    $0x4,%eax
 909:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 90c:	e9 37 ff ff ff       	jmp    848 <printf+0x48>
 911:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 918:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 91b:	8b 08                	mov    (%eax),%ecx
        ap++;
 91d:	83 c0 04             	add    $0x4,%eax
 920:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 923:	85 c9                	test   %ecx,%ecx
 925:	0f 84 8e 00 00 00    	je     9b9 <printf+0x1b9>
        while(*s != 0){
 92b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 92e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 930:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 932:	84 c0                	test   %al,%al
 934:	0f 84 0e ff ff ff    	je     848 <printf+0x48>
 93a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 93d:	89 de                	mov    %ebx,%esi
 93f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 942:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 945:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 948:	83 ec 04             	sub    $0x4,%esp
          s++;
 94b:	83 c6 01             	add    $0x1,%esi
 94e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 951:	6a 01                	push   $0x1
 953:	57                   	push   %edi
 954:	53                   	push   %ebx
 955:	e8 2c fd ff ff       	call   686 <write>
        while(*s != 0){
 95a:	0f b6 06             	movzbl (%esi),%eax
 95d:	83 c4 10             	add    $0x10,%esp
 960:	84 c0                	test   %al,%al
 962:	75 e4                	jne    948 <printf+0x148>
 964:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 967:	31 ff                	xor    %edi,%edi
 969:	e9 da fe ff ff       	jmp    848 <printf+0x48>
 96e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 970:	83 ec 0c             	sub    $0xc,%esp
 973:	b9 0a 00 00 00       	mov    $0xa,%ecx
 978:	6a 01                	push   $0x1
 97a:	e9 73 ff ff ff       	jmp    8f2 <printf+0xf2>
 97f:	90                   	nop
  write(fd, &c, 1);
 980:	83 ec 04             	sub    $0x4,%esp
 983:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 986:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 989:	6a 01                	push   $0x1
 98b:	e9 21 ff ff ff       	jmp    8b1 <printf+0xb1>
        putc(fd, *ap);
 990:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 993:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 996:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 998:	6a 01                	push   $0x1
        ap++;
 99a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 99d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 9a0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 9a3:	50                   	push   %eax
 9a4:	ff 75 08             	pushl  0x8(%ebp)
 9a7:	e8 da fc ff ff       	call   686 <write>
        ap++;
 9ac:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 9af:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9b2:	31 ff                	xor    %edi,%edi
 9b4:	e9 8f fe ff ff       	jmp    848 <printf+0x48>
          s = "(null)";
 9b9:	bb b9 0b 00 00       	mov    $0xbb9,%ebx
        while(*s != 0){
 9be:	b8 28 00 00 00       	mov    $0x28,%eax
 9c3:	e9 72 ff ff ff       	jmp    93a <printf+0x13a>
 9c8:	66 90                	xchg   %ax,%ax
 9ca:	66 90                	xchg   %ax,%ax
 9cc:	66 90                	xchg   %ax,%ax
 9ce:	66 90                	xchg   %ax,%ax

000009d0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9d0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9d1:	a1 30 0f 00 00       	mov    0xf30,%eax
{
 9d6:	89 e5                	mov    %esp,%ebp
 9d8:	57                   	push   %edi
 9d9:	56                   	push   %esi
 9da:	53                   	push   %ebx
 9db:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 9de:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 9e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9e8:	39 c8                	cmp    %ecx,%eax
 9ea:	8b 10                	mov    (%eax),%edx
 9ec:	73 32                	jae    a20 <free+0x50>
 9ee:	39 d1                	cmp    %edx,%ecx
 9f0:	72 04                	jb     9f6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9f2:	39 d0                	cmp    %edx,%eax
 9f4:	72 32                	jb     a28 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9f6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9f9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9fc:	39 fa                	cmp    %edi,%edx
 9fe:	74 30                	je     a30 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 a00:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a03:	8b 50 04             	mov    0x4(%eax),%edx
 a06:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a09:	39 f1                	cmp    %esi,%ecx
 a0b:	74 3a                	je     a47 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 a0d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 a0f:	a3 30 0f 00 00       	mov    %eax,0xf30
}
 a14:	5b                   	pop    %ebx
 a15:	5e                   	pop    %esi
 a16:	5f                   	pop    %edi
 a17:	5d                   	pop    %ebp
 a18:	c3                   	ret    
 a19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a20:	39 d0                	cmp    %edx,%eax
 a22:	72 04                	jb     a28 <free+0x58>
 a24:	39 d1                	cmp    %edx,%ecx
 a26:	72 ce                	jb     9f6 <free+0x26>
{
 a28:	89 d0                	mov    %edx,%eax
 a2a:	eb bc                	jmp    9e8 <free+0x18>
 a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 a30:	03 72 04             	add    0x4(%edx),%esi
 a33:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a36:	8b 10                	mov    (%eax),%edx
 a38:	8b 12                	mov    (%edx),%edx
 a3a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a3d:	8b 50 04             	mov    0x4(%eax),%edx
 a40:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a43:	39 f1                	cmp    %esi,%ecx
 a45:	75 c6                	jne    a0d <free+0x3d>
    p->s.size += bp->s.size;
 a47:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 a4a:	a3 30 0f 00 00       	mov    %eax,0xf30
    p->s.size += bp->s.size;
 a4f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a52:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a55:	89 10                	mov    %edx,(%eax)
}
 a57:	5b                   	pop    %ebx
 a58:	5e                   	pop    %esi
 a59:	5f                   	pop    %edi
 a5a:	5d                   	pop    %ebp
 a5b:	c3                   	ret    
 a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a60 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a60:	55                   	push   %ebp
 a61:	89 e5                	mov    %esp,%ebp
 a63:	57                   	push   %edi
 a64:	56                   	push   %esi
 a65:	53                   	push   %ebx
 a66:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a69:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a6c:	8b 15 30 0f 00 00    	mov    0xf30,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a72:	8d 78 07             	lea    0x7(%eax),%edi
 a75:	c1 ef 03             	shr    $0x3,%edi
 a78:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a7b:	85 d2                	test   %edx,%edx
 a7d:	0f 84 9d 00 00 00    	je     b20 <malloc+0xc0>
 a83:	8b 02                	mov    (%edx),%eax
 a85:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a88:	39 cf                	cmp    %ecx,%edi
 a8a:	76 6c                	jbe    af8 <malloc+0x98>
 a8c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 a92:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a97:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a9a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 aa1:	eb 0e                	jmp    ab1 <malloc+0x51>
 aa3:	90                   	nop
 aa4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 aa8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 aaa:	8b 48 04             	mov    0x4(%eax),%ecx
 aad:	39 f9                	cmp    %edi,%ecx
 aaf:	73 47                	jae    af8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ab1:	39 05 30 0f 00 00    	cmp    %eax,0xf30
 ab7:	89 c2                	mov    %eax,%edx
 ab9:	75 ed                	jne    aa8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 abb:	83 ec 0c             	sub    $0xc,%esp
 abe:	56                   	push   %esi
 abf:	e8 2a fc ff ff       	call   6ee <sbrk>
  if(p == (char*)-1)
 ac4:	83 c4 10             	add    $0x10,%esp
 ac7:	83 f8 ff             	cmp    $0xffffffff,%eax
 aca:	74 1c                	je     ae8 <malloc+0x88>
  hp->s.size = nu;
 acc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 acf:	83 ec 0c             	sub    $0xc,%esp
 ad2:	83 c0 08             	add    $0x8,%eax
 ad5:	50                   	push   %eax
 ad6:	e8 f5 fe ff ff       	call   9d0 <free>
  return freep;
 adb:	8b 15 30 0f 00 00    	mov    0xf30,%edx
      if((p = morecore(nunits)) == 0)
 ae1:	83 c4 10             	add    $0x10,%esp
 ae4:	85 d2                	test   %edx,%edx
 ae6:	75 c0                	jne    aa8 <malloc+0x48>
        return 0;
  }
}
 ae8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 aeb:	31 c0                	xor    %eax,%eax
}
 aed:	5b                   	pop    %ebx
 aee:	5e                   	pop    %esi
 aef:	5f                   	pop    %edi
 af0:	5d                   	pop    %ebp
 af1:	c3                   	ret    
 af2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 af8:	39 cf                	cmp    %ecx,%edi
 afa:	74 54                	je     b50 <malloc+0xf0>
        p->s.size -= nunits;
 afc:	29 f9                	sub    %edi,%ecx
 afe:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b01:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b04:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b07:	89 15 30 0f 00 00    	mov    %edx,0xf30
}
 b0d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b10:	83 c0 08             	add    $0x8,%eax
}
 b13:	5b                   	pop    %ebx
 b14:	5e                   	pop    %esi
 b15:	5f                   	pop    %edi
 b16:	5d                   	pop    %ebp
 b17:	c3                   	ret    
 b18:	90                   	nop
 b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 b20:	c7 05 30 0f 00 00 34 	movl   $0xf34,0xf30
 b27:	0f 00 00 
 b2a:	c7 05 34 0f 00 00 34 	movl   $0xf34,0xf34
 b31:	0f 00 00 
    base.s.size = 0;
 b34:	b8 34 0f 00 00       	mov    $0xf34,%eax
 b39:	c7 05 38 0f 00 00 00 	movl   $0x0,0xf38
 b40:	00 00 00 
 b43:	e9 44 ff ff ff       	jmp    a8c <malloc+0x2c>
 b48:	90                   	nop
 b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 b50:	8b 08                	mov    (%eax),%ecx
 b52:	89 0a                	mov    %ecx,(%edx)
 b54:	eb b1                	jmp    b07 <malloc+0xa7>
