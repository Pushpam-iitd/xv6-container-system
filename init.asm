
_init:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
// extern void init_queues(void);


int
main(void)
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	53                   	push   %ebx
   e:	51                   	push   %ecx
  int pid, wpid;

  // init_queues();

  if(open("console", O_RDWR) < 0){
   f:	83 ec 08             	sub    $0x8,%esp
  12:	6a 02                	push   $0x2
  14:	68 e8 0b 00 00       	push   $0xbe8
  19:	e8 18 07 00 00       	call   736 <open>
  1e:	83 c4 10             	add    $0x10,%esp
  21:	85 c0                	test   %eax,%eax
  23:	0f 88 9f 00 00 00    	js     c8 <main+0xc8>
    mknod("console", 1, 1);
    open("console", O_RDWR);
  }
  dup(0);  // stdout
  29:	83 ec 0c             	sub    $0xc,%esp
  2c:	6a 00                	push   $0x0
  2e:	e8 3b 07 00 00       	call   76e <dup>
  dup(0);  // stderr
  33:	c7 04 24 00 00 00 00 	movl   $0x0,(%esp)
  3a:	e8 2f 07 00 00       	call   76e <dup>
  3f:	83 c4 10             	add    $0x10,%esp
  42:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi

  for(;;){
    printf(1, "init: starting sh\n");
  48:	83 ec 08             	sub    $0x8,%esp
  4b:	68 f0 0b 00 00       	push   $0xbf0
  50:	6a 01                	push   $0x1
  52:	e8 39 08 00 00       	call   890 <printf>
    pid = fork();
  57:	e8 92 06 00 00       	call   6ee <fork>
    if(pid < 0){
  5c:	83 c4 10             	add    $0x10,%esp
  5f:	85 c0                	test   %eax,%eax
    pid = fork();
  61:	89 c3                	mov    %eax,%ebx
    if(pid < 0){
  63:	78 2c                	js     91 <main+0x91>
      printf(1, "init: fork failed\n");
      exit();
    }
    if(pid == 0){
  65:	74 3d                	je     a4 <main+0xa4>
  67:	89 f6                	mov    %esi,%esi
  69:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
      exec("sh", argv);
      printf(1, "init: exec sh failed\n");
      exit();
    }
    while((wpid=wait()) >= 0 && wpid != pid)
  70:	e8 89 06 00 00       	call   6fe <wait>
  75:	85 c0                	test   %eax,%eax
  77:	78 cf                	js     48 <main+0x48>
  79:	39 c3                	cmp    %eax,%ebx
  7b:	74 cb                	je     48 <main+0x48>
      printf(1, "zombie!\n");
  7d:	83 ec 08             	sub    $0x8,%esp
  80:	68 2f 0c 00 00       	push   $0xc2f
  85:	6a 01                	push   $0x1
  87:	e8 04 08 00 00       	call   890 <printf>
  8c:	83 c4 10             	add    $0x10,%esp
  8f:	eb df                	jmp    70 <main+0x70>
      printf(1, "init: fork failed\n");
  91:	53                   	push   %ebx
  92:	53                   	push   %ebx
  93:	68 03 0c 00 00       	push   $0xc03
  98:	6a 01                	push   $0x1
  9a:	e8 f1 07 00 00       	call   890 <printf>
      exit();
  9f:	e8 52 06 00 00       	call   6f6 <exit>
      exec("sh", argv);
  a4:	50                   	push   %eax
  a5:	50                   	push   %eax
  a6:	68 f4 0f 00 00       	push   $0xff4
  ab:	68 16 0c 00 00       	push   $0xc16
  b0:	e8 79 06 00 00       	call   72e <exec>
      printf(1, "init: exec sh failed\n");
  b5:	5a                   	pop    %edx
  b6:	59                   	pop    %ecx
  b7:	68 19 0c 00 00       	push   $0xc19
  bc:	6a 01                	push   $0x1
  be:	e8 cd 07 00 00       	call   890 <printf>
      exit();
  c3:	e8 2e 06 00 00       	call   6f6 <exit>
    mknod("console", 1, 1);
  c8:	50                   	push   %eax
  c9:	6a 01                	push   $0x1
  cb:	6a 01                	push   $0x1
  cd:	68 e8 0b 00 00       	push   $0xbe8
  d2:	e8 67 06 00 00       	call   73e <mknod>
    open("console", O_RDWR);
  d7:	58                   	pop    %eax
  d8:	5a                   	pop    %edx
  d9:	6a 02                	push   $0x2
  db:	68 e8 0b 00 00       	push   $0xbe8
  e0:	e8 51 06 00 00       	call   736 <open>
  e5:	83 c4 10             	add    $0x10,%esp
  e8:	e9 3c ff ff ff       	jmp    29 <main+0x29>
  ed:	66 90                	xchg   %ax,%ax
  ef:	90                   	nop

000000f0 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  f0:	55                   	push   %ebp
  f1:	89 e5                	mov    %esp,%ebp
  f3:	53                   	push   %ebx
  f4:	8b 45 08             	mov    0x8(%ebp),%eax
  f7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  fa:	89 c2                	mov    %eax,%edx
  fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 100:	83 c1 01             	add    $0x1,%ecx
 103:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 107:	83 c2 01             	add    $0x1,%edx
 10a:	84 db                	test   %bl,%bl
 10c:	88 5a ff             	mov    %bl,-0x1(%edx)
 10f:	75 ef                	jne    100 <strcpy+0x10>
    ;
  return os;
}
 111:	5b                   	pop    %ebx
 112:	5d                   	pop    %ebp
 113:	c3                   	ret    
 114:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 11a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000120 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 120:	55                   	push   %ebp
 121:	89 e5                	mov    %esp,%ebp
 123:	53                   	push   %ebx
 124:	8b 55 08             	mov    0x8(%ebp),%edx
 127:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 12a:	0f b6 02             	movzbl (%edx),%eax
 12d:	0f b6 19             	movzbl (%ecx),%ebx
 130:	84 c0                	test   %al,%al
 132:	75 1c                	jne    150 <strcmp+0x30>
 134:	eb 2a                	jmp    160 <strcmp+0x40>
 136:	8d 76 00             	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 140:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 143:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 146:	83 c1 01             	add    $0x1,%ecx
 149:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 14c:	84 c0                	test   %al,%al
 14e:	74 10                	je     160 <strcmp+0x40>
 150:	38 d8                	cmp    %bl,%al
 152:	74 ec                	je     140 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 154:	29 d8                	sub    %ebx,%eax
}
 156:	5b                   	pop    %ebx
 157:	5d                   	pop    %ebp
 158:	c3                   	ret    
 159:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 160:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 162:	29 d8                	sub    %ebx,%eax
}
 164:	5b                   	pop    %ebx
 165:	5d                   	pop    %ebp
 166:	c3                   	ret    
 167:	89 f6                	mov    %esi,%esi
 169:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000170 <strlen>:

uint
strlen(const char *s)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 176:	80 39 00             	cmpb   $0x0,(%ecx)
 179:	74 15                	je     190 <strlen+0x20>
 17b:	31 d2                	xor    %edx,%edx
 17d:	8d 76 00             	lea    0x0(%esi),%esi
 180:	83 c2 01             	add    $0x1,%edx
 183:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 187:	89 d0                	mov    %edx,%eax
 189:	75 f5                	jne    180 <strlen+0x10>
    ;
  return n;
}
 18b:	5d                   	pop    %ebp
 18c:	c3                   	ret    
 18d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 190:	31 c0                	xor    %eax,%eax
}
 192:	5d                   	pop    %ebp
 193:	c3                   	ret    
 194:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 19a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001a0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1a7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1aa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1ad:	89 d7                	mov    %edx,%edi
 1af:	fc                   	cld    
 1b0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 1b2:	89 d0                	mov    %edx,%eax
 1b4:	5f                   	pop    %edi
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	89 f6                	mov    %esi,%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <strchr>:

char*
strchr(const char *s, char c)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	53                   	push   %ebx
 1c4:	8b 45 08             	mov    0x8(%ebp),%eax
 1c7:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 1ca:	0f b6 10             	movzbl (%eax),%edx
 1cd:	84 d2                	test   %dl,%dl
 1cf:	74 1d                	je     1ee <strchr+0x2e>
    if(*s == c)
 1d1:	38 d3                	cmp    %dl,%bl
 1d3:	89 d9                	mov    %ebx,%ecx
 1d5:	75 0d                	jne    1e4 <strchr+0x24>
 1d7:	eb 17                	jmp    1f0 <strchr+0x30>
 1d9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1e0:	38 ca                	cmp    %cl,%dl
 1e2:	74 0c                	je     1f0 <strchr+0x30>
  for(; *s; s++)
 1e4:	83 c0 01             	add    $0x1,%eax
 1e7:	0f b6 10             	movzbl (%eax),%edx
 1ea:	84 d2                	test   %dl,%dl
 1ec:	75 f2                	jne    1e0 <strchr+0x20>
      return (char*)s;
  return 0;
 1ee:	31 c0                	xor    %eax,%eax
}
 1f0:	5b                   	pop    %ebx
 1f1:	5d                   	pop    %ebp
 1f2:	c3                   	ret    
 1f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <gets>:

char*
gets(char *buf, int max)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	57                   	push   %edi
 204:	56                   	push   %esi
 205:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 206:	31 f6                	xor    %esi,%esi
 208:	89 f3                	mov    %esi,%ebx
{
 20a:	83 ec 1c             	sub    $0x1c,%esp
 20d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 210:	eb 2f                	jmp    241 <gets+0x41>
 212:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 218:	8d 45 e7             	lea    -0x19(%ebp),%eax
 21b:	83 ec 04             	sub    $0x4,%esp
 21e:	6a 01                	push   $0x1
 220:	50                   	push   %eax
 221:	6a 00                	push   $0x0
 223:	e8 e6 04 00 00       	call   70e <read>
    if(cc < 1)
 228:	83 c4 10             	add    $0x10,%esp
 22b:	85 c0                	test   %eax,%eax
 22d:	7e 1c                	jle    24b <gets+0x4b>
      break;
    buf[i++] = c;
 22f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 233:	83 c7 01             	add    $0x1,%edi
 236:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 239:	3c 0a                	cmp    $0xa,%al
 23b:	74 23                	je     260 <gets+0x60>
 23d:	3c 0d                	cmp    $0xd,%al
 23f:	74 1f                	je     260 <gets+0x60>
  for(i=0; i+1 < max; ){
 241:	83 c3 01             	add    $0x1,%ebx
 244:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 247:	89 fe                	mov    %edi,%esi
 249:	7c cd                	jl     218 <gets+0x18>
 24b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 24d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 250:	c6 03 00             	movb   $0x0,(%ebx)
}
 253:	8d 65 f4             	lea    -0xc(%ebp),%esp
 256:	5b                   	pop    %ebx
 257:	5e                   	pop    %esi
 258:	5f                   	pop    %edi
 259:	5d                   	pop    %ebp
 25a:	c3                   	ret    
 25b:	90                   	nop
 25c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 260:	8b 75 08             	mov    0x8(%ebp),%esi
 263:	8b 45 08             	mov    0x8(%ebp),%eax
 266:	01 de                	add    %ebx,%esi
 268:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 26a:	c6 03 00             	movb   $0x0,(%ebx)
}
 26d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 270:	5b                   	pop    %ebx
 271:	5e                   	pop    %esi
 272:	5f                   	pop    %edi
 273:	5d                   	pop    %ebp
 274:	c3                   	ret    
 275:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 279:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000280 <stat>:

int
stat(const char *n, struct stat *st)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 285:	83 ec 08             	sub    $0x8,%esp
 288:	6a 00                	push   $0x0
 28a:	ff 75 08             	pushl  0x8(%ebp)
 28d:	e8 a4 04 00 00       	call   736 <open>
  if(fd < 0)
 292:	83 c4 10             	add    $0x10,%esp
 295:	85 c0                	test   %eax,%eax
 297:	78 27                	js     2c0 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 299:	83 ec 08             	sub    $0x8,%esp
 29c:	ff 75 0c             	pushl  0xc(%ebp)
 29f:	89 c3                	mov    %eax,%ebx
 2a1:	50                   	push   %eax
 2a2:	e8 a7 04 00 00       	call   74e <fstat>
  close(fd);
 2a7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2aa:	89 c6                	mov    %eax,%esi
  close(fd);
 2ac:	e8 6d 04 00 00       	call   71e <close>
  return r;
 2b1:	83 c4 10             	add    $0x10,%esp
}
 2b4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 2b7:	89 f0                	mov    %esi,%eax
 2b9:	5b                   	pop    %ebx
 2ba:	5e                   	pop    %esi
 2bb:	5d                   	pop    %ebp
 2bc:	c3                   	ret    
 2bd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 2c0:	be ff ff ff ff       	mov    $0xffffffff,%esi
 2c5:	eb ed                	jmp    2b4 <stat+0x34>
 2c7:	89 f6                	mov    %esi,%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <atoi>:

int
atoi(const char *s)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	53                   	push   %ebx
 2d4:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 2d7:	0f be 11             	movsbl (%ecx),%edx
 2da:	8d 42 d0             	lea    -0x30(%edx),%eax
 2dd:	3c 09                	cmp    $0x9,%al
  n = 0;
 2df:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 2e4:	77 1f                	ja     305 <atoi+0x35>
 2e6:	8d 76 00             	lea    0x0(%esi),%esi
 2e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 2f0:	8d 04 80             	lea    (%eax,%eax,4),%eax
 2f3:	83 c1 01             	add    $0x1,%ecx
 2f6:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 2fa:	0f be 11             	movsbl (%ecx),%edx
 2fd:	8d 5a d0             	lea    -0x30(%edx),%ebx
 300:	80 fb 09             	cmp    $0x9,%bl
 303:	76 eb                	jbe    2f0 <atoi+0x20>
  return n;
}
 305:	5b                   	pop    %ebx
 306:	5d                   	pop    %ebp
 307:	c3                   	ret    
 308:	90                   	nop
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000310 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	53                   	push   %ebx
 315:	8b 5d 10             	mov    0x10(%ebp),%ebx
 318:	8b 45 08             	mov    0x8(%ebp),%eax
 31b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 31e:	85 db                	test   %ebx,%ebx
 320:	7e 14                	jle    336 <memmove+0x26>
 322:	31 d2                	xor    %edx,%edx
 324:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 328:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 32c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 32f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 332:	39 d3                	cmp    %edx,%ebx
 334:	75 f2                	jne    328 <memmove+0x18>
  return vdst;
}
 336:	5b                   	pop    %ebx
 337:	5e                   	pop    %esi
 338:	5d                   	pop    %ebp
 339:	c3                   	ret    
 33a:	66 90                	xchg   %ax,%ax
 33c:	66 90                	xchg   %ax,%ax
 33e:	66 90                	xchg   %ax,%ax

00000340 <mystrcmp>:
#include "ls.h"
// #include "defs.h"

int
mystrcmp (char *s1, char *s2)
{
 340:	55                   	push   %ebp
 341:	89 e5                	mov    %esp,%ebp
 343:	56                   	push   %esi
 344:	53                   	push   %ebx
 345:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int a =0,b=0;
 348:	31 db                	xor    %ebx,%ebx
{
 34a:	8b 55 0c             	mov    0xc(%ebp),%edx
    while(*s1){a++;s1++;}
 34d:	80 39 00             	cmpb   $0x0,(%ecx)
 350:	0f b6 02             	movzbl (%edx),%eax
 353:	74 33                	je     388 <mystrcmp+0x48>
 355:	8d 76 00             	lea    0x0(%esi),%esi
 358:	83 c1 01             	add    $0x1,%ecx
 35b:	83 c3 01             	add    $0x1,%ebx
 35e:	80 39 00             	cmpb   $0x0,(%ecx)
 361:	75 f5                	jne    358 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
 363:	84 c0                	test   %al,%al
 365:	74 51                	je     3b8 <mystrcmp+0x78>
    int a =0,b=0;
 367:	31 f6                	xor    %esi,%esi
 369:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
 370:	83 c2 01             	add    $0x1,%edx
 373:	83 c6 01             	add    $0x1,%esi
 376:	80 3a 00             	cmpb   $0x0,(%edx)
 379:	75 f5                	jne    370 <mystrcmp+0x30>

    if(a!=b)return 0;
 37b:	31 c0                	xor    %eax,%eax
 37d:	39 de                	cmp    %ebx,%esi
 37f:	74 0f                	je     390 <mystrcmp+0x50>
    // printf("here");
    while(a--){
        if(*s1++ != *s2++)return 0;
    }
    return 1;
}
 381:	5b                   	pop    %ebx
 382:	5e                   	pop    %esi
 383:	5d                   	pop    %ebp
 384:	c3                   	ret    
 385:	8d 76 00             	lea    0x0(%esi),%esi
    while(*s2){b++;s2++;}
 388:	84 c0                	test   %al,%al
 38a:	75 db                	jne    367 <mystrcmp+0x27>
 38c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 390:	01 d3                	add    %edx,%ebx
 392:	eb 13                	jmp    3a7 <mystrcmp+0x67>
 394:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(*s1++ != *s2++)return 0;
 398:	83 c2 01             	add    $0x1,%edx
 39b:	83 c1 01             	add    $0x1,%ecx
 39e:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
 3a2:	38 41 ff             	cmp    %al,-0x1(%ecx)
 3a5:	75 11                	jne    3b8 <mystrcmp+0x78>
    while(a--){
 3a7:	39 d3                	cmp    %edx,%ebx
 3a9:	75 ed                	jne    398 <mystrcmp+0x58>
}
 3ab:	5b                   	pop    %ebx
    return 1;
 3ac:	b8 01 00 00 00       	mov    $0x1,%eax
}
 3b1:	5e                   	pop    %esi
 3b2:	5d                   	pop    %ebp
 3b3:	c3                   	ret    
 3b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3b8:	5b                   	pop    %ebx
    if(a!=b)return 0;
 3b9:	31 c0                	xor    %eax,%eax
}
 3bb:	5e                   	pop    %esi
 3bc:	5d                   	pop    %ebp
 3bd:	c3                   	ret    
 3be:	66 90                	xchg   %ax,%ax

000003c0 <fmtname>:

char*
fmtname(char *path)
{
 3c0:	55                   	push   %ebp
 3c1:	89 e5                	mov    %esp,%ebp
 3c3:	56                   	push   %esi
 3c4:	53                   	push   %ebx
 3c5:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
 3c8:	83 ec 0c             	sub    $0xc,%esp
 3cb:	53                   	push   %ebx
 3cc:	e8 9f fd ff ff       	call   170 <strlen>
 3d1:	83 c4 10             	add    $0x10,%esp
 3d4:	01 d8                	add    %ebx,%eax
 3d6:	73 0f                	jae    3e7 <fmtname+0x27>
 3d8:	eb 12                	jmp    3ec <fmtname+0x2c>
 3da:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3e0:	83 e8 01             	sub    $0x1,%eax
 3e3:	39 c3                	cmp    %eax,%ebx
 3e5:	77 05                	ja     3ec <fmtname+0x2c>
 3e7:	80 38 2f             	cmpb   $0x2f,(%eax)
 3ea:	75 f4                	jne    3e0 <fmtname+0x20>
    ;
  p++;
 3ec:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
 3ef:	83 ec 0c             	sub    $0xc,%esp
 3f2:	53                   	push   %ebx
 3f3:	e8 78 fd ff ff       	call   170 <strlen>
 3f8:	83 c4 10             	add    $0x10,%esp
 3fb:	83 f8 0d             	cmp    $0xd,%eax
 3fe:	77 4a                	ja     44a <fmtname+0x8a>
    return p;
  memmove(buf, p, strlen(p));
 400:	83 ec 0c             	sub    $0xc,%esp
 403:	53                   	push   %ebx
 404:	e8 67 fd ff ff       	call   170 <strlen>
 409:	83 c4 0c             	add    $0xc,%esp
 40c:	50                   	push   %eax
 40d:	53                   	push   %ebx
 40e:	68 00 10 00 00       	push   $0x1000
 413:	e8 f8 fe ff ff       	call   310 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 418:	89 1c 24             	mov    %ebx,(%esp)
 41b:	e8 50 fd ff ff       	call   170 <strlen>
 420:	89 1c 24             	mov    %ebx,(%esp)
 423:	89 c6                	mov    %eax,%esi
  return buf;
 425:	bb 00 10 00 00       	mov    $0x1000,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 42a:	e8 41 fd ff ff       	call   170 <strlen>
 42f:	ba 0e 00 00 00       	mov    $0xe,%edx
 434:	83 c4 0c             	add    $0xc,%esp
 437:	05 00 10 00 00       	add    $0x1000,%eax
 43c:	29 f2                	sub    %esi,%edx
 43e:	52                   	push   %edx
 43f:	6a 20                	push   $0x20
 441:	50                   	push   %eax
 442:	e8 59 fd ff ff       	call   1a0 <memset>
  return buf;
 447:	83 c4 10             	add    $0x10,%esp
}
 44a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 44d:	89 d8                	mov    %ebx,%eax
 44f:	5b                   	pop    %ebx
 450:	5e                   	pop    %esi
 451:	5d                   	pop    %ebp
 452:	c3                   	ret    
 453:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 459:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000460 <ls>:

void
ls(char *path)
{
 460:	55                   	push   %ebp
 461:	89 e5                	mov    %esp,%ebp
 463:	57                   	push   %edi
 464:	56                   	push   %esi
 465:	53                   	push   %ebx
 466:	81 ec 5c 02 00 00    	sub    $0x25c,%esp

  int cid = getcid();
 46c:	e8 6d 03 00 00       	call   7de <getcid>

  printf(2, "Cid is: %d\n", cid);
 471:	83 ec 04             	sub    $0x4,%esp
  int cid = getcid();
 474:	89 c7                	mov    %eax,%edi
  printf(2, "Cid is: %d\n", cid);
 476:	50                   	push   %eax
 477:	68 38 0c 00 00       	push   $0xc38
 47c:	6a 02                	push   $0x2
 47e:	e8 0d 04 00 00       	call   890 <printf>
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  if((fd = open(path, 0)) < 0){
 483:	59                   	pop    %ecx
 484:	5b                   	pop    %ebx
 485:	6a 00                	push   $0x0
 487:	ff 75 08             	pushl  0x8(%ebp)
 48a:	e8 a7 02 00 00       	call   736 <open>
 48f:	83 c4 10             	add    $0x10,%esp
 492:	85 c0                	test   %eax,%eax
 494:	78 5a                	js     4f0 <ls+0x90>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 496:	8d b5 d0 fd ff ff    	lea    -0x230(%ebp),%esi
 49c:	83 ec 08             	sub    $0x8,%esp
 49f:	89 c3                	mov    %eax,%ebx
 4a1:	56                   	push   %esi
 4a2:	50                   	push   %eax
 4a3:	e8 a6 02 00 00       	call   74e <fstat>
 4a8:	83 c4 10             	add    $0x10,%esp
 4ab:	85 c0                	test   %eax,%eax
 4ad:	0f 88 cd 00 00 00    	js     580 <ls+0x120>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  switch(st.type){
 4b3:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 4ba:	66 83 f8 01          	cmp    $0x1,%ax
 4be:	74 50                	je     510 <ls+0xb0>
 4c0:	66 83 f8 02          	cmp    $0x2,%ax
 4c4:	75 12                	jne    4d8 <ls+0x78>
  case T_FILE:
    if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 4c6:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 4cc:	8d 42 01             	lea    0x1(%edx),%eax
 4cf:	83 f8 01             	cmp    $0x1,%eax
 4d2:	76 6c                	jbe    540 <ls+0xe0>
 4d4:	39 fa                	cmp    %edi,%edx
 4d6:	74 68                	je     540 <ls+0xe0>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
    }
    break;
  }
  close(fd);
 4d8:	83 ec 0c             	sub    $0xc,%esp
 4db:	53                   	push   %ebx
 4dc:	e8 3d 02 00 00       	call   71e <close>
 4e1:	83 c4 10             	add    $0x10,%esp

}
 4e4:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4e7:	5b                   	pop    %ebx
 4e8:	5e                   	pop    %esi
 4e9:	5f                   	pop    %edi
 4ea:	5d                   	pop    %ebp
 4eb:	c3                   	ret    
 4ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
 4f0:	83 ec 04             	sub    $0x4,%esp
 4f3:	ff 75 08             	pushl  0x8(%ebp)
 4f6:	68 44 0c 00 00       	push   $0xc44
 4fb:	6a 02                	push   $0x2
 4fd:	e8 8e 03 00 00       	call   890 <printf>
    return;
 502:	83 c4 10             	add    $0x10,%esp
}
 505:	8d 65 f4             	lea    -0xc(%ebp),%esp
 508:	5b                   	pop    %ebx
 509:	5e                   	pop    %esi
 50a:	5f                   	pop    %edi
 50b:	5d                   	pop    %ebp
 50c:	c3                   	ret    
 50d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 510:	83 ec 0c             	sub    $0xc,%esp
 513:	ff 75 08             	pushl  0x8(%ebp)
 516:	e8 55 fc ff ff       	call   170 <strlen>
 51b:	83 c0 10             	add    $0x10,%eax
 51e:	83 c4 10             	add    $0x10,%esp
 521:	3d 00 02 00 00       	cmp    $0x200,%eax
 526:	0f 86 7c 00 00 00    	jbe    5a8 <ls+0x148>
      printf(1, "ls: path too long\n");
 52c:	83 ec 08             	sub    $0x8,%esp
 52f:	68 7c 0c 00 00       	push   $0xc7c
 534:	6a 01                	push   $0x1
 536:	e8 55 03 00 00       	call   890 <printf>
      break;
 53b:	83 c4 10             	add    $0x10,%esp
 53e:	eb 98                	jmp    4d8 <ls+0x78>
    printf(1, "%s %d %d %d %d\n", fmtname(path), st.type, st.ino, st.size, st.cid);
 540:	83 ec 0c             	sub    $0xc,%esp
 543:	ff 75 08             	pushl  0x8(%ebp)
 546:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 54c:	8b bd e0 fd ff ff    	mov    -0x220(%ebp),%edi
 552:	8b b5 d8 fd ff ff    	mov    -0x228(%ebp),%esi
 558:	e8 63 fe ff ff       	call   3c0 <fmtname>
 55d:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 563:	83 c4 0c             	add    $0xc,%esp
 566:	52                   	push   %edx
 567:	57                   	push   %edi
 568:	56                   	push   %esi
 569:	6a 02                	push   $0x2
 56b:	50                   	push   %eax
 56c:	68 6c 0c 00 00       	push   $0xc6c
 571:	6a 01                	push   $0x1
 573:	e8 18 03 00 00       	call   890 <printf>
    break;
 578:	83 c4 20             	add    $0x20,%esp
 57b:	e9 58 ff ff ff       	jmp    4d8 <ls+0x78>
    printf(2, "ls: cannot stat %s\n", path);
 580:	83 ec 04             	sub    $0x4,%esp
 583:	ff 75 08             	pushl  0x8(%ebp)
 586:	68 58 0c 00 00       	push   $0xc58
 58b:	6a 02                	push   $0x2
 58d:	e8 fe 02 00 00       	call   890 <printf>
    close(fd);
 592:	89 1c 24             	mov    %ebx,(%esp)
 595:	e8 84 01 00 00       	call   71e <close>
    return;
 59a:	83 c4 10             	add    $0x10,%esp
}
 59d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5a0:	5b                   	pop    %ebx
 5a1:	5e                   	pop    %esi
 5a2:	5f                   	pop    %edi
 5a3:	5d                   	pop    %ebp
 5a4:	c3                   	ret    
 5a5:	8d 76 00             	lea    0x0(%esi),%esi
    strcpy(buf, path);
 5a8:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 5ae:	83 ec 08             	sub    $0x8,%esp
 5b1:	ff 75 08             	pushl  0x8(%ebp)
 5b4:	50                   	push   %eax
 5b5:	e8 36 fb ff ff       	call   f0 <strcpy>
    p = buf+strlen(buf);
 5ba:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 5c0:	89 04 24             	mov    %eax,(%esp)
 5c3:	e8 a8 fb ff ff       	call   170 <strlen>
 5c8:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 5ce:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 5d1:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 5d3:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 5d6:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 5dc:	c6 00 2f             	movb   $0x2f,(%eax)
 5df:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 5e5:	8d 76 00             	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 5e8:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
 5ee:	83 ec 04             	sub    $0x4,%esp
 5f1:	6a 10                	push   $0x10
 5f3:	50                   	push   %eax
 5f4:	53                   	push   %ebx
 5f5:	e8 14 01 00 00       	call   70e <read>
 5fa:	83 c4 10             	add    $0x10,%esp
 5fd:	83 f8 10             	cmp    $0x10,%eax
 600:	0f 85 d2 fe ff ff    	jne    4d8 <ls+0x78>
      if(de.inum == 0)
 606:	66 83 bd c0 fd ff ff 	cmpw   $0x0,-0x240(%ebp)
 60d:	00 
 60e:	74 d8                	je     5e8 <ls+0x188>
      memmove(p, de.name, DIRSIZ);
 610:	8d 85 c2 fd ff ff    	lea    -0x23e(%ebp),%eax
 616:	83 ec 04             	sub    $0x4,%esp
 619:	6a 0e                	push   $0xe
 61b:	50                   	push   %eax
 61c:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 622:	e8 e9 fc ff ff       	call   310 <memmove>
      p[DIRSIZ] = 0;
 627:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 62d:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 631:	58                   	pop    %eax
 632:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 638:	5a                   	pop    %edx
 639:	56                   	push   %esi
 63a:	50                   	push   %eax
 63b:	e8 40 fc ff ff       	call   280 <stat>
 640:	83 c4 10             	add    $0x10,%esp
 643:	85 c0                	test   %eax,%eax
 645:	0f 88 85 00 00 00    	js     6d0 <ls+0x270>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 64b:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 651:	8d 42 01             	lea    0x1(%edx),%eax
 654:	83 f8 01             	cmp    $0x1,%eax
 657:	76 04                	jbe    65d <ls+0x1fd>
 659:	39 fa                	cmp    %edi,%edx
 65b:	75 8b                	jne    5e8 <ls+0x188>
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
 65d:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
 663:	89 95 a0 fd ff ff    	mov    %edx,-0x260(%ebp)
 669:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 66f:	83 ec 0c             	sub    $0xc,%esp
 672:	8b 85 d8 fd ff ff    	mov    -0x228(%ebp),%eax
 678:	52                   	push   %edx
 679:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 67f:	0f bf 8d d0 fd ff ff 	movswl -0x230(%ebp),%ecx
 686:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 68c:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 692:	e8 29 fd ff ff       	call   3c0 <fmtname>
 697:	8b 95 a0 fd ff ff    	mov    -0x260(%ebp),%edx
 69d:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
 6a3:	83 c4 0c             	add    $0xc,%esp
 6a6:	52                   	push   %edx
 6a7:	51                   	push   %ecx
 6a8:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 6ae:	ff b5 a8 fd ff ff    	pushl  -0x258(%ebp)
 6b4:	50                   	push   %eax
 6b5:	68 6c 0c 00 00       	push   $0xc6c
 6ba:	6a 01                	push   $0x1
 6bc:	e8 cf 01 00 00       	call   890 <printf>
 6c1:	83 c4 20             	add    $0x20,%esp
 6c4:	e9 1f ff ff ff       	jmp    5e8 <ls+0x188>
 6c9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 6d0:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 6d6:	83 ec 04             	sub    $0x4,%esp
 6d9:	50                   	push   %eax
 6da:	68 58 0c 00 00       	push   $0xc58
 6df:	6a 01                	push   $0x1
 6e1:	e8 aa 01 00 00       	call   890 <printf>
        continue;
 6e6:	83 c4 10             	add    $0x10,%esp
 6e9:	e9 fa fe ff ff       	jmp    5e8 <ls+0x188>

000006ee <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 6ee:	b8 01 00 00 00       	mov    $0x1,%eax
 6f3:	cd 40                	int    $0x40
 6f5:	c3                   	ret    

000006f6 <exit>:
SYSCALL(exit)
 6f6:	b8 02 00 00 00       	mov    $0x2,%eax
 6fb:	cd 40                	int    $0x40
 6fd:	c3                   	ret    

000006fe <wait>:
SYSCALL(wait)
 6fe:	b8 03 00 00 00       	mov    $0x3,%eax
 703:	cd 40                	int    $0x40
 705:	c3                   	ret    

00000706 <pipe>:
SYSCALL(pipe)
 706:	b8 04 00 00 00       	mov    $0x4,%eax
 70b:	cd 40                	int    $0x40
 70d:	c3                   	ret    

0000070e <read>:
SYSCALL(read)
 70e:	b8 05 00 00 00       	mov    $0x5,%eax
 713:	cd 40                	int    $0x40
 715:	c3                   	ret    

00000716 <write>:
SYSCALL(write)
 716:	b8 10 00 00 00       	mov    $0x10,%eax
 71b:	cd 40                	int    $0x40
 71d:	c3                   	ret    

0000071e <close>:
SYSCALL(close)
 71e:	b8 15 00 00 00       	mov    $0x15,%eax
 723:	cd 40                	int    $0x40
 725:	c3                   	ret    

00000726 <kill>:
SYSCALL(kill)
 726:	b8 06 00 00 00       	mov    $0x6,%eax
 72b:	cd 40                	int    $0x40
 72d:	c3                   	ret    

0000072e <exec>:
SYSCALL(exec)
 72e:	b8 07 00 00 00       	mov    $0x7,%eax
 733:	cd 40                	int    $0x40
 735:	c3                   	ret    

00000736 <open>:
SYSCALL(open)
 736:	b8 0f 00 00 00       	mov    $0xf,%eax
 73b:	cd 40                	int    $0x40
 73d:	c3                   	ret    

0000073e <mknod>:
SYSCALL(mknod)
 73e:	b8 11 00 00 00       	mov    $0x11,%eax
 743:	cd 40                	int    $0x40
 745:	c3                   	ret    

00000746 <unlink>:
SYSCALL(unlink)
 746:	b8 12 00 00 00       	mov    $0x12,%eax
 74b:	cd 40                	int    $0x40
 74d:	c3                   	ret    

0000074e <fstat>:
SYSCALL(fstat)
 74e:	b8 08 00 00 00       	mov    $0x8,%eax
 753:	cd 40                	int    $0x40
 755:	c3                   	ret    

00000756 <link>:
SYSCALL(link)
 756:	b8 13 00 00 00       	mov    $0x13,%eax
 75b:	cd 40                	int    $0x40
 75d:	c3                   	ret    

0000075e <mkdir>:
SYSCALL(mkdir)
 75e:	b8 14 00 00 00       	mov    $0x14,%eax
 763:	cd 40                	int    $0x40
 765:	c3                   	ret    

00000766 <chdir>:
SYSCALL(chdir)
 766:	b8 09 00 00 00       	mov    $0x9,%eax
 76b:	cd 40                	int    $0x40
 76d:	c3                   	ret    

0000076e <dup>:
SYSCALL(dup)
 76e:	b8 0a 00 00 00       	mov    $0xa,%eax
 773:	cd 40                	int    $0x40
 775:	c3                   	ret    

00000776 <getpid>:
SYSCALL(getpid)
 776:	b8 0b 00 00 00       	mov    $0xb,%eax
 77b:	cd 40                	int    $0x40
 77d:	c3                   	ret    

0000077e <sbrk>:
SYSCALL(sbrk)
 77e:	b8 0c 00 00 00       	mov    $0xc,%eax
 783:	cd 40                	int    $0x40
 785:	c3                   	ret    

00000786 <sleep>:
SYSCALL(sleep)
 786:	b8 0d 00 00 00       	mov    $0xd,%eax
 78b:	cd 40                	int    $0x40
 78d:	c3                   	ret    

0000078e <uptime>:
SYSCALL(uptime)
 78e:	b8 0e 00 00 00       	mov    $0xe,%eax
 793:	cd 40                	int    $0x40
 795:	c3                   	ret    

00000796 <halt>:
SYSCALL(halt)
 796:	b8 16 00 00 00       	mov    $0x16,%eax
 79b:	cd 40                	int    $0x40
 79d:	c3                   	ret    

0000079e <toggle>:
SYSCALL(toggle)
 79e:	b8 17 00 00 00       	mov    $0x17,%eax
 7a3:	cd 40                	int    $0x40
 7a5:	c3                   	ret    

000007a6 <ps>:
SYSCALL(ps)
 7a6:	b8 18 00 00 00       	mov    $0x18,%eax
 7ab:	cd 40                	int    $0x40
 7ad:	c3                   	ret    

000007ae <create_container>:
SYSCALL(create_container)
 7ae:	b8 1c 00 00 00       	mov    $0x1c,%eax
 7b3:	cd 40                	int    $0x40
 7b5:	c3                   	ret    

000007b6 <destroy_container>:
SYSCALL(destroy_container)
 7b6:	b8 19 00 00 00       	mov    $0x19,%eax
 7bb:	cd 40                	int    $0x40
 7bd:	c3                   	ret    

000007be <join_container>:
SYSCALL(join_container)
 7be:	b8 1a 00 00 00       	mov    $0x1a,%eax
 7c3:	cd 40                	int    $0x40
 7c5:	c3                   	ret    

000007c6 <leave_container>:
SYSCALL(leave_container)
 7c6:	b8 1b 00 00 00       	mov    $0x1b,%eax
 7cb:	cd 40                	int    $0x40
 7cd:	c3                   	ret    

000007ce <send>:
SYSCALL(send)
 7ce:	b8 1d 00 00 00       	mov    $0x1d,%eax
 7d3:	cd 40                	int    $0x40
 7d5:	c3                   	ret    

000007d6 <recv>:
SYSCALL(recv)
 7d6:	b8 1e 00 00 00       	mov    $0x1e,%eax
 7db:	cd 40                	int    $0x40
 7dd:	c3                   	ret    

000007de <getcid>:
SYSCALL(getcid)
 7de:	b8 1f 00 00 00       	mov    $0x1f,%eax
 7e3:	cd 40                	int    $0x40
 7e5:	c3                   	ret    
 7e6:	66 90                	xchg   %ax,%ax
 7e8:	66 90                	xchg   %ax,%ax
 7ea:	66 90                	xchg   %ax,%ax
 7ec:	66 90                	xchg   %ax,%ax
 7ee:	66 90                	xchg   %ax,%ax

000007f0 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 7f0:	55                   	push   %ebp
 7f1:	89 e5                	mov    %esp,%ebp
 7f3:	57                   	push   %edi
 7f4:	56                   	push   %esi
 7f5:	53                   	push   %ebx
 7f6:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 7f9:	85 d2                	test   %edx,%edx
{
 7fb:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 7fe:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 800:	79 76                	jns    878 <printint+0x88>
 802:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 806:	74 70                	je     878 <printint+0x88>
    x = -xx;
 808:	f7 d8                	neg    %eax
    neg = 1;
 80a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 811:	31 f6                	xor    %esi,%esi
 813:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 816:	eb 0a                	jmp    822 <printint+0x32>
 818:	90                   	nop
 819:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 820:	89 fe                	mov    %edi,%esi
 822:	31 d2                	xor    %edx,%edx
 824:	8d 7e 01             	lea    0x1(%esi),%edi
 827:	f7 f1                	div    %ecx
 829:	0f b6 92 98 0c 00 00 	movzbl 0xc98(%edx),%edx
  }while((x /= base) != 0);
 830:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 832:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 835:	75 e9                	jne    820 <printint+0x30>
  if(neg)
 837:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 83a:	85 c0                	test   %eax,%eax
 83c:	74 08                	je     846 <printint+0x56>
    buf[i++] = '-';
 83e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 843:	8d 7e 02             	lea    0x2(%esi),%edi
 846:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 84a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 84d:	8d 76 00             	lea    0x0(%esi),%esi
 850:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 853:	83 ec 04             	sub    $0x4,%esp
 856:	83 ee 01             	sub    $0x1,%esi
 859:	6a 01                	push   $0x1
 85b:	53                   	push   %ebx
 85c:	57                   	push   %edi
 85d:	88 45 d7             	mov    %al,-0x29(%ebp)
 860:	e8 b1 fe ff ff       	call   716 <write>

  while(--i >= 0)
 865:	83 c4 10             	add    $0x10,%esp
 868:	39 de                	cmp    %ebx,%esi
 86a:	75 e4                	jne    850 <printint+0x60>
    putc(fd, buf[i]);
}
 86c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 86f:	5b                   	pop    %ebx
 870:	5e                   	pop    %esi
 871:	5f                   	pop    %edi
 872:	5d                   	pop    %ebp
 873:	c3                   	ret    
 874:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 878:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 87f:	eb 90                	jmp    811 <printint+0x21>
 881:	eb 0d                	jmp    890 <printf>
 883:	90                   	nop
 884:	90                   	nop
 885:	90                   	nop
 886:	90                   	nop
 887:	90                   	nop
 888:	90                   	nop
 889:	90                   	nop
 88a:	90                   	nop
 88b:	90                   	nop
 88c:	90                   	nop
 88d:	90                   	nop
 88e:	90                   	nop
 88f:	90                   	nop

00000890 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 890:	55                   	push   %ebp
 891:	89 e5                	mov    %esp,%ebp
 893:	57                   	push   %edi
 894:	56                   	push   %esi
 895:	53                   	push   %ebx
 896:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 899:	8b 75 0c             	mov    0xc(%ebp),%esi
 89c:	0f b6 1e             	movzbl (%esi),%ebx
 89f:	84 db                	test   %bl,%bl
 8a1:	0f 84 b3 00 00 00    	je     95a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 8a7:	8d 45 10             	lea    0x10(%ebp),%eax
 8aa:	83 c6 01             	add    $0x1,%esi
  state = 0;
 8ad:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 8af:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 8b2:	eb 2f                	jmp    8e3 <printf+0x53>
 8b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 8b8:	83 f8 25             	cmp    $0x25,%eax
 8bb:	0f 84 a7 00 00 00    	je     968 <printf+0xd8>
  write(fd, &c, 1);
 8c1:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 8c4:	83 ec 04             	sub    $0x4,%esp
 8c7:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 8ca:	6a 01                	push   $0x1
 8cc:	50                   	push   %eax
 8cd:	ff 75 08             	pushl  0x8(%ebp)
 8d0:	e8 41 fe ff ff       	call   716 <write>
 8d5:	83 c4 10             	add    $0x10,%esp
 8d8:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 8db:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 8df:	84 db                	test   %bl,%bl
 8e1:	74 77                	je     95a <printf+0xca>
    if(state == 0){
 8e3:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 8e5:	0f be cb             	movsbl %bl,%ecx
 8e8:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 8eb:	74 cb                	je     8b8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 8ed:	83 ff 25             	cmp    $0x25,%edi
 8f0:	75 e6                	jne    8d8 <printf+0x48>
      if(c == 'd'){
 8f2:	83 f8 64             	cmp    $0x64,%eax
 8f5:	0f 84 05 01 00 00    	je     a00 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 8fb:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 901:	83 f9 70             	cmp    $0x70,%ecx
 904:	74 72                	je     978 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 906:	83 f8 73             	cmp    $0x73,%eax
 909:	0f 84 99 00 00 00    	je     9a8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 90f:	83 f8 63             	cmp    $0x63,%eax
 912:	0f 84 08 01 00 00    	je     a20 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 918:	83 f8 25             	cmp    $0x25,%eax
 91b:	0f 84 ef 00 00 00    	je     a10 <printf+0x180>
  write(fd, &c, 1);
 921:	8d 45 e7             	lea    -0x19(%ebp),%eax
 924:	83 ec 04             	sub    $0x4,%esp
 927:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 92b:	6a 01                	push   $0x1
 92d:	50                   	push   %eax
 92e:	ff 75 08             	pushl  0x8(%ebp)
 931:	e8 e0 fd ff ff       	call   716 <write>
 936:	83 c4 0c             	add    $0xc,%esp
 939:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 93c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 93f:	6a 01                	push   $0x1
 941:	50                   	push   %eax
 942:	ff 75 08             	pushl  0x8(%ebp)
 945:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 948:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 94a:	e8 c7 fd ff ff       	call   716 <write>
  for(i = 0; fmt[i]; i++){
 94f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 953:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 956:	84 db                	test   %bl,%bl
 958:	75 89                	jne    8e3 <printf+0x53>
    }
  }
}
 95a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 95d:	5b                   	pop    %ebx
 95e:	5e                   	pop    %esi
 95f:	5f                   	pop    %edi
 960:	5d                   	pop    %ebp
 961:	c3                   	ret    
 962:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 968:	bf 25 00 00 00       	mov    $0x25,%edi
 96d:	e9 66 ff ff ff       	jmp    8d8 <printf+0x48>
 972:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 978:	83 ec 0c             	sub    $0xc,%esp
 97b:	b9 10 00 00 00       	mov    $0x10,%ecx
 980:	6a 00                	push   $0x0
 982:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 985:	8b 45 08             	mov    0x8(%ebp),%eax
 988:	8b 17                	mov    (%edi),%edx
 98a:	e8 61 fe ff ff       	call   7f0 <printint>
        ap++;
 98f:	89 f8                	mov    %edi,%eax
 991:	83 c4 10             	add    $0x10,%esp
      state = 0;
 994:	31 ff                	xor    %edi,%edi
        ap++;
 996:	83 c0 04             	add    $0x4,%eax
 999:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 99c:	e9 37 ff ff ff       	jmp    8d8 <printf+0x48>
 9a1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 9a8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 9ab:	8b 08                	mov    (%eax),%ecx
        ap++;
 9ad:	83 c0 04             	add    $0x4,%eax
 9b0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 9b3:	85 c9                	test   %ecx,%ecx
 9b5:	0f 84 8e 00 00 00    	je     a49 <printf+0x1b9>
        while(*s != 0){
 9bb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 9be:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 9c0:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 9c2:	84 c0                	test   %al,%al
 9c4:	0f 84 0e ff ff ff    	je     8d8 <printf+0x48>
 9ca:	89 75 d0             	mov    %esi,-0x30(%ebp)
 9cd:	89 de                	mov    %ebx,%esi
 9cf:	8b 5d 08             	mov    0x8(%ebp),%ebx
 9d2:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 9d5:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 9d8:	83 ec 04             	sub    $0x4,%esp
          s++;
 9db:	83 c6 01             	add    $0x1,%esi
 9de:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 9e1:	6a 01                	push   $0x1
 9e3:	57                   	push   %edi
 9e4:	53                   	push   %ebx
 9e5:	e8 2c fd ff ff       	call   716 <write>
        while(*s != 0){
 9ea:	0f b6 06             	movzbl (%esi),%eax
 9ed:	83 c4 10             	add    $0x10,%esp
 9f0:	84 c0                	test   %al,%al
 9f2:	75 e4                	jne    9d8 <printf+0x148>
 9f4:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 9f7:	31 ff                	xor    %edi,%edi
 9f9:	e9 da fe ff ff       	jmp    8d8 <printf+0x48>
 9fe:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 a00:	83 ec 0c             	sub    $0xc,%esp
 a03:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a08:	6a 01                	push   $0x1
 a0a:	e9 73 ff ff ff       	jmp    982 <printf+0xf2>
 a0f:	90                   	nop
  write(fd, &c, 1);
 a10:	83 ec 04             	sub    $0x4,%esp
 a13:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 a16:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 a19:	6a 01                	push   $0x1
 a1b:	e9 21 ff ff ff       	jmp    941 <printf+0xb1>
        putc(fd, *ap);
 a20:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 a23:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 a26:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 a28:	6a 01                	push   $0x1
        ap++;
 a2a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 a2d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 a30:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 a33:	50                   	push   %eax
 a34:	ff 75 08             	pushl  0x8(%ebp)
 a37:	e8 da fc ff ff       	call   716 <write>
        ap++;
 a3c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 a3f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a42:	31 ff                	xor    %edi,%edi
 a44:	e9 8f fe ff ff       	jmp    8d8 <printf+0x48>
          s = "(null)";
 a49:	bb 8f 0c 00 00       	mov    $0xc8f,%ebx
        while(*s != 0){
 a4e:	b8 28 00 00 00       	mov    $0x28,%eax
 a53:	e9 72 ff ff ff       	jmp    9ca <printf+0x13a>
 a58:	66 90                	xchg   %ax,%ax
 a5a:	66 90                	xchg   %ax,%ax
 a5c:	66 90                	xchg   %ax,%ax
 a5e:	66 90                	xchg   %ax,%ax

00000a60 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a60:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a61:	a1 10 10 00 00       	mov    0x1010,%eax
{
 a66:	89 e5                	mov    %esp,%ebp
 a68:	57                   	push   %edi
 a69:	56                   	push   %esi
 a6a:	53                   	push   %ebx
 a6b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a6e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 a71:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a78:	39 c8                	cmp    %ecx,%eax
 a7a:	8b 10                	mov    (%eax),%edx
 a7c:	73 32                	jae    ab0 <free+0x50>
 a7e:	39 d1                	cmp    %edx,%ecx
 a80:	72 04                	jb     a86 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a82:	39 d0                	cmp    %edx,%eax
 a84:	72 32                	jb     ab8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a86:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a89:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a8c:	39 fa                	cmp    %edi,%edx
 a8e:	74 30                	je     ac0 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 a90:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a93:	8b 50 04             	mov    0x4(%eax),%edx
 a96:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a99:	39 f1                	cmp    %esi,%ecx
 a9b:	74 3a                	je     ad7 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 a9d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 a9f:	a3 10 10 00 00       	mov    %eax,0x1010
}
 aa4:	5b                   	pop    %ebx
 aa5:	5e                   	pop    %esi
 aa6:	5f                   	pop    %edi
 aa7:	5d                   	pop    %ebp
 aa8:	c3                   	ret    
 aa9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ab0:	39 d0                	cmp    %edx,%eax
 ab2:	72 04                	jb     ab8 <free+0x58>
 ab4:	39 d1                	cmp    %edx,%ecx
 ab6:	72 ce                	jb     a86 <free+0x26>
{
 ab8:	89 d0                	mov    %edx,%eax
 aba:	eb bc                	jmp    a78 <free+0x18>
 abc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 ac0:	03 72 04             	add    0x4(%edx),%esi
 ac3:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 ac6:	8b 10                	mov    (%eax),%edx
 ac8:	8b 12                	mov    (%edx),%edx
 aca:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 acd:	8b 50 04             	mov    0x4(%eax),%edx
 ad0:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 ad3:	39 f1                	cmp    %esi,%ecx
 ad5:	75 c6                	jne    a9d <free+0x3d>
    p->s.size += bp->s.size;
 ad7:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 ada:	a3 10 10 00 00       	mov    %eax,0x1010
    p->s.size += bp->s.size;
 adf:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 ae2:	8b 53 f8             	mov    -0x8(%ebx),%edx
 ae5:	89 10                	mov    %edx,(%eax)
}
 ae7:	5b                   	pop    %ebx
 ae8:	5e                   	pop    %esi
 ae9:	5f                   	pop    %edi
 aea:	5d                   	pop    %ebp
 aeb:	c3                   	ret    
 aec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000af0 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 af0:	55                   	push   %ebp
 af1:	89 e5                	mov    %esp,%ebp
 af3:	57                   	push   %edi
 af4:	56                   	push   %esi
 af5:	53                   	push   %ebx
 af6:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 af9:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 afc:	8b 15 10 10 00 00    	mov    0x1010,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b02:	8d 78 07             	lea    0x7(%eax),%edi
 b05:	c1 ef 03             	shr    $0x3,%edi
 b08:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b0b:	85 d2                	test   %edx,%edx
 b0d:	0f 84 9d 00 00 00    	je     bb0 <malloc+0xc0>
 b13:	8b 02                	mov    (%edx),%eax
 b15:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b18:	39 cf                	cmp    %ecx,%edi
 b1a:	76 6c                	jbe    b88 <malloc+0x98>
 b1c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 b22:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b27:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 b2a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 b31:	eb 0e                	jmp    b41 <malloc+0x51>
 b33:	90                   	nop
 b34:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b38:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b3a:	8b 48 04             	mov    0x4(%eax),%ecx
 b3d:	39 f9                	cmp    %edi,%ecx
 b3f:	73 47                	jae    b88 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b41:	39 05 10 10 00 00    	cmp    %eax,0x1010
 b47:	89 c2                	mov    %eax,%edx
 b49:	75 ed                	jne    b38 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 b4b:	83 ec 0c             	sub    $0xc,%esp
 b4e:	56                   	push   %esi
 b4f:	e8 2a fc ff ff       	call   77e <sbrk>
  if(p == (char*)-1)
 b54:	83 c4 10             	add    $0x10,%esp
 b57:	83 f8 ff             	cmp    $0xffffffff,%eax
 b5a:	74 1c                	je     b78 <malloc+0x88>
  hp->s.size = nu;
 b5c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 b5f:	83 ec 0c             	sub    $0xc,%esp
 b62:	83 c0 08             	add    $0x8,%eax
 b65:	50                   	push   %eax
 b66:	e8 f5 fe ff ff       	call   a60 <free>
  return freep;
 b6b:	8b 15 10 10 00 00    	mov    0x1010,%edx
      if((p = morecore(nunits)) == 0)
 b71:	83 c4 10             	add    $0x10,%esp
 b74:	85 d2                	test   %edx,%edx
 b76:	75 c0                	jne    b38 <malloc+0x48>
        return 0;
  }
}
 b78:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b7b:	31 c0                	xor    %eax,%eax
}
 b7d:	5b                   	pop    %ebx
 b7e:	5e                   	pop    %esi
 b7f:	5f                   	pop    %edi
 b80:	5d                   	pop    %ebp
 b81:	c3                   	ret    
 b82:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b88:	39 cf                	cmp    %ecx,%edi
 b8a:	74 54                	je     be0 <malloc+0xf0>
        p->s.size -= nunits;
 b8c:	29 f9                	sub    %edi,%ecx
 b8e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b91:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b94:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b97:	89 15 10 10 00 00    	mov    %edx,0x1010
}
 b9d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 ba0:	83 c0 08             	add    $0x8,%eax
}
 ba3:	5b                   	pop    %ebx
 ba4:	5e                   	pop    %esi
 ba5:	5f                   	pop    %edi
 ba6:	5d                   	pop    %ebp
 ba7:	c3                   	ret    
 ba8:	90                   	nop
 ba9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 bb0:	c7 05 10 10 00 00 14 	movl   $0x1014,0x1010
 bb7:	10 00 00 
 bba:	c7 05 14 10 00 00 14 	movl   $0x1014,0x1014
 bc1:	10 00 00 
    base.s.size = 0;
 bc4:	b8 14 10 00 00       	mov    $0x1014,%eax
 bc9:	c7 05 18 10 00 00 00 	movl   $0x0,0x1018
 bd0:	00 00 00 
 bd3:	e9 44 ff ff ff       	jmp    b1c <malloc+0x2c>
 bd8:	90                   	nop
 bd9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 be0:	8b 08                	mov    (%eax),%ecx
 be2:	89 0a                	mov    %ecx,(%edx)
 be4:	eb b1                	jmp    b97 <malloc+0xa7>
