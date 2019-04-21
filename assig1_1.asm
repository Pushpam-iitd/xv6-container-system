
_assig1_1:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fcntl.h"


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
	int pid;
	int k;
	for (k = 1; k <= 3; k++) {
   f:	bb 01 00 00 00       	mov    $0x1,%ebx
			pid = fork();
  14:	e8 75 06 00 00       	call   68e <fork>
			if (pid == -1) {
  19:	83 f8 ff             	cmp    $0xffffffff,%eax
  1c:	74 57                	je     75 <main+0x75>
					printf(1,"fork failed\n");
					// return;
					break;
			}
			if (pid == 0) {              // child process
  1e:	85 c0                	test   %eax,%eax
  20:	74 0d                	je     2f <main+0x2f>
	for (k = 1; k <= 3; k++) {
  22:	83 c3 01             	add    $0x1,%ebx
  25:	83 fb 04             	cmp    $0x4,%ebx
  28:	75 ea                	jne    14 <main+0x14>
    close(fd2);
		ps();
		exit();
	}
	else{
		exit();
  2a:	e8 67 06 00 00       	call   696 <exit>
		create_container(k);
  2f:	83 ec 0c             	sub    $0xc,%esp
  32:	53                   	push   %ebx
  33:	e8 16 07 00 00       	call   74e <create_container>
		join_container(k);
  38:	89 1c 24             	mov    %ebx,(%esp)
  3b:	e8 1e 07 00 00       	call   75e <join_container>
    int fd2 = open("arrn", O_CREATE | O_RDWR);
  40:	58                   	pop    %eax
  41:	5a                   	pop    %edx
  42:	68 02 02 00 00       	push   $0x202
  47:	68 95 0b 00 00       	push   $0xb95
  4c:	e8 85 06 00 00       	call   6d6 <open>
    write(fd2,s,5);
  51:	83 c4 0c             	add    $0xc,%esp
    int fd2 = open("arrn", O_CREATE | O_RDWR);
  54:	89 c3                	mov    %eax,%ebx
    write(fd2,s,5);
  56:	6a 05                	push   $0x5
  58:	68 9a 0b 00 00       	push   $0xb9a
  5d:	50                   	push   %eax
  5e:	e8 53 06 00 00       	call   6b6 <write>
    close(fd2);
  63:	89 1c 24             	mov    %ebx,(%esp)
  66:	e8 53 06 00 00       	call   6be <close>
		ps();
  6b:	e8 d6 06 00 00       	call   746 <ps>
		exit();
  70:	e8 21 06 00 00       	call   696 <exit>
					printf(1,"fork failed\n");
  75:	51                   	push   %ecx
  76:	51                   	push   %ecx
  77:	68 88 0b 00 00       	push   $0xb88
  7c:	6a 01                	push   $0x1
  7e:	e8 ad 07 00 00       	call   830 <printf>
  83:	83 c4 10             	add    $0x10,%esp
  86:	eb a2                	jmp    2a <main+0x2a>
  88:	66 90                	xchg   %ax,%ax
  8a:	66 90                	xchg   %ax,%ax
  8c:	66 90                	xchg   %ax,%ax
  8e:	66 90                	xchg   %ax,%ax

00000090 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  90:	55                   	push   %ebp
  91:	89 e5                	mov    %esp,%ebp
  93:	53                   	push   %ebx
  94:	8b 45 08             	mov    0x8(%ebp),%eax
  97:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  9a:	89 c2                	mov    %eax,%edx
  9c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  a0:	83 c1 01             	add    $0x1,%ecx
  a3:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  a7:	83 c2 01             	add    $0x1,%edx
  aa:	84 db                	test   %bl,%bl
  ac:	88 5a ff             	mov    %bl,-0x1(%edx)
  af:	75 ef                	jne    a0 <strcpy+0x10>
    ;
  return os;
}
  b1:	5b                   	pop    %ebx
  b2:	5d                   	pop    %ebp
  b3:	c3                   	ret    
  b4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  ba:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000c0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  c0:	55                   	push   %ebp
  c1:	89 e5                	mov    %esp,%ebp
  c3:	53                   	push   %ebx
  c4:	8b 55 08             	mov    0x8(%ebp),%edx
  c7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  ca:	0f b6 02             	movzbl (%edx),%eax
  cd:	0f b6 19             	movzbl (%ecx),%ebx
  d0:	84 c0                	test   %al,%al
  d2:	75 1c                	jne    f0 <strcmp+0x30>
  d4:	eb 2a                	jmp    100 <strcmp+0x40>
  d6:	8d 76 00             	lea    0x0(%esi),%esi
  d9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  e0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  e3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  e6:	83 c1 01             	add    $0x1,%ecx
  e9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  ec:	84 c0                	test   %al,%al
  ee:	74 10                	je     100 <strcmp+0x40>
  f0:	38 d8                	cmp    %bl,%al
  f2:	74 ec                	je     e0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  f4:	29 d8                	sub    %ebx,%eax
}
  f6:	5b                   	pop    %ebx
  f7:	5d                   	pop    %ebp
  f8:	c3                   	ret    
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 100:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 102:	29 d8                	sub    %ebx,%eax
}
 104:	5b                   	pop    %ebx
 105:	5d                   	pop    %ebp
 106:	c3                   	ret    
 107:	89 f6                	mov    %esi,%esi
 109:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000110 <strlen>:

uint
strlen(const char *s)
{
 110:	55                   	push   %ebp
 111:	89 e5                	mov    %esp,%ebp
 113:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 116:	80 39 00             	cmpb   $0x0,(%ecx)
 119:	74 15                	je     130 <strlen+0x20>
 11b:	31 d2                	xor    %edx,%edx
 11d:	8d 76 00             	lea    0x0(%esi),%esi
 120:	83 c2 01             	add    $0x1,%edx
 123:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 127:	89 d0                	mov    %edx,%eax
 129:	75 f5                	jne    120 <strlen+0x10>
    ;
  return n;
}
 12b:	5d                   	pop    %ebp
 12c:	c3                   	ret    
 12d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 130:	31 c0                	xor    %eax,%eax
}
 132:	5d                   	pop    %ebp
 133:	c3                   	ret    
 134:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 13a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000140 <memset>:

void*
memset(void *dst, int c, uint n)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 147:	8b 4d 10             	mov    0x10(%ebp),%ecx
 14a:	8b 45 0c             	mov    0xc(%ebp),%eax
 14d:	89 d7                	mov    %edx,%edi
 14f:	fc                   	cld    
 150:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 152:	89 d0                	mov    %edx,%eax
 154:	5f                   	pop    %edi
 155:	5d                   	pop    %ebp
 156:	c3                   	ret    
 157:	89 f6                	mov    %esi,%esi
 159:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000160 <strchr>:

char*
strchr(const char *s, char c)
{
 160:	55                   	push   %ebp
 161:	89 e5                	mov    %esp,%ebp
 163:	53                   	push   %ebx
 164:	8b 45 08             	mov    0x8(%ebp),%eax
 167:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 16a:	0f b6 10             	movzbl (%eax),%edx
 16d:	84 d2                	test   %dl,%dl
 16f:	74 1d                	je     18e <strchr+0x2e>
    if(*s == c)
 171:	38 d3                	cmp    %dl,%bl
 173:	89 d9                	mov    %ebx,%ecx
 175:	75 0d                	jne    184 <strchr+0x24>
 177:	eb 17                	jmp    190 <strchr+0x30>
 179:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 180:	38 ca                	cmp    %cl,%dl
 182:	74 0c                	je     190 <strchr+0x30>
  for(; *s; s++)
 184:	83 c0 01             	add    $0x1,%eax
 187:	0f b6 10             	movzbl (%eax),%edx
 18a:	84 d2                	test   %dl,%dl
 18c:	75 f2                	jne    180 <strchr+0x20>
      return (char*)s;
  return 0;
 18e:	31 c0                	xor    %eax,%eax
}
 190:	5b                   	pop    %ebx
 191:	5d                   	pop    %ebp
 192:	c3                   	ret    
 193:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 199:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001a0 <gets>:

char*
gets(char *buf, int max)
{
 1a0:	55                   	push   %ebp
 1a1:	89 e5                	mov    %esp,%ebp
 1a3:	57                   	push   %edi
 1a4:	56                   	push   %esi
 1a5:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 1a6:	31 f6                	xor    %esi,%esi
 1a8:	89 f3                	mov    %esi,%ebx
{
 1aa:	83 ec 1c             	sub    $0x1c,%esp
 1ad:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 1b0:	eb 2f                	jmp    1e1 <gets+0x41>
 1b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 1b8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 1bb:	83 ec 04             	sub    $0x4,%esp
 1be:	6a 01                	push   $0x1
 1c0:	50                   	push   %eax
 1c1:	6a 00                	push   $0x0
 1c3:	e8 e6 04 00 00       	call   6ae <read>
    if(cc < 1)
 1c8:	83 c4 10             	add    $0x10,%esp
 1cb:	85 c0                	test   %eax,%eax
 1cd:	7e 1c                	jle    1eb <gets+0x4b>
      break;
    buf[i++] = c;
 1cf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 1d3:	83 c7 01             	add    $0x1,%edi
 1d6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 1d9:	3c 0a                	cmp    $0xa,%al
 1db:	74 23                	je     200 <gets+0x60>
 1dd:	3c 0d                	cmp    $0xd,%al
 1df:	74 1f                	je     200 <gets+0x60>
  for(i=0; i+1 < max; ){
 1e1:	83 c3 01             	add    $0x1,%ebx
 1e4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 1e7:	89 fe                	mov    %edi,%esi
 1e9:	7c cd                	jl     1b8 <gets+0x18>
 1eb:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 1ed:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 1f0:	c6 03 00             	movb   $0x0,(%ebx)
}
 1f3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1f6:	5b                   	pop    %ebx
 1f7:	5e                   	pop    %esi
 1f8:	5f                   	pop    %edi
 1f9:	5d                   	pop    %ebp
 1fa:	c3                   	ret    
 1fb:	90                   	nop
 1fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 200:	8b 75 08             	mov    0x8(%ebp),%esi
 203:	8b 45 08             	mov    0x8(%ebp),%eax
 206:	01 de                	add    %ebx,%esi
 208:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 20a:	c6 03 00             	movb   $0x0,(%ebx)
}
 20d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 210:	5b                   	pop    %ebx
 211:	5e                   	pop    %esi
 212:	5f                   	pop    %edi
 213:	5d                   	pop    %ebp
 214:	c3                   	ret    
 215:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 219:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000220 <stat>:

int
stat(const char *n, struct stat *st)
{
 220:	55                   	push   %ebp
 221:	89 e5                	mov    %esp,%ebp
 223:	56                   	push   %esi
 224:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 225:	83 ec 08             	sub    $0x8,%esp
 228:	6a 00                	push   $0x0
 22a:	ff 75 08             	pushl  0x8(%ebp)
 22d:	e8 a4 04 00 00       	call   6d6 <open>
  if(fd < 0)
 232:	83 c4 10             	add    $0x10,%esp
 235:	85 c0                	test   %eax,%eax
 237:	78 27                	js     260 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 239:	83 ec 08             	sub    $0x8,%esp
 23c:	ff 75 0c             	pushl  0xc(%ebp)
 23f:	89 c3                	mov    %eax,%ebx
 241:	50                   	push   %eax
 242:	e8 a7 04 00 00       	call   6ee <fstat>
  close(fd);
 247:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 24a:	89 c6                	mov    %eax,%esi
  close(fd);
 24c:	e8 6d 04 00 00       	call   6be <close>
  return r;
 251:	83 c4 10             	add    $0x10,%esp
}
 254:	8d 65 f8             	lea    -0x8(%ebp),%esp
 257:	89 f0                	mov    %esi,%eax
 259:	5b                   	pop    %ebx
 25a:	5e                   	pop    %esi
 25b:	5d                   	pop    %ebp
 25c:	c3                   	ret    
 25d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 260:	be ff ff ff ff       	mov    $0xffffffff,%esi
 265:	eb ed                	jmp    254 <stat+0x34>
 267:	89 f6                	mov    %esi,%esi
 269:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000270 <atoi>:

int
atoi(const char *s)
{
 270:	55                   	push   %ebp
 271:	89 e5                	mov    %esp,%ebp
 273:	53                   	push   %ebx
 274:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 277:	0f be 11             	movsbl (%ecx),%edx
 27a:	8d 42 d0             	lea    -0x30(%edx),%eax
 27d:	3c 09                	cmp    $0x9,%al
  n = 0;
 27f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 284:	77 1f                	ja     2a5 <atoi+0x35>
 286:	8d 76 00             	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 290:	8d 04 80             	lea    (%eax,%eax,4),%eax
 293:	83 c1 01             	add    $0x1,%ecx
 296:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 29a:	0f be 11             	movsbl (%ecx),%edx
 29d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 2a0:	80 fb 09             	cmp    $0x9,%bl
 2a3:	76 eb                	jbe    290 <atoi+0x20>
  return n;
}
 2a5:	5b                   	pop    %ebx
 2a6:	5d                   	pop    %ebp
 2a7:	c3                   	ret    
 2a8:	90                   	nop
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000002b0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 2b0:	55                   	push   %ebp
 2b1:	89 e5                	mov    %esp,%ebp
 2b3:	56                   	push   %esi
 2b4:	53                   	push   %ebx
 2b5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 2b8:	8b 45 08             	mov    0x8(%ebp),%eax
 2bb:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 2be:	85 db                	test   %ebx,%ebx
 2c0:	7e 14                	jle    2d6 <memmove+0x26>
 2c2:	31 d2                	xor    %edx,%edx
 2c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 2c8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 2cc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 2cf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 2d2:	39 d3                	cmp    %edx,%ebx
 2d4:	75 f2                	jne    2c8 <memmove+0x18>
  return vdst;
}
 2d6:	5b                   	pop    %ebx
 2d7:	5e                   	pop    %esi
 2d8:	5d                   	pop    %ebp
 2d9:	c3                   	ret    
 2da:	66 90                	xchg   %ax,%ax
 2dc:	66 90                	xchg   %ax,%ax
 2de:	66 90                	xchg   %ax,%ax

000002e0 <mystrcmp>:
#include "ls.h"
// #include "defs.h"

int
mystrcmp (char *s1, char *s2)
{
 2e0:	55                   	push   %ebp
 2e1:	89 e5                	mov    %esp,%ebp
 2e3:	56                   	push   %esi
 2e4:	53                   	push   %ebx
 2e5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int a =0,b=0;
 2e8:	31 db                	xor    %ebx,%ebx
{
 2ea:	8b 55 0c             	mov    0xc(%ebp),%edx
    while(*s1){a++;s1++;}
 2ed:	80 39 00             	cmpb   $0x0,(%ecx)
 2f0:	0f b6 02             	movzbl (%edx),%eax
 2f3:	74 33                	je     328 <mystrcmp+0x48>
 2f5:	8d 76 00             	lea    0x0(%esi),%esi
 2f8:	83 c1 01             	add    $0x1,%ecx
 2fb:	83 c3 01             	add    $0x1,%ebx
 2fe:	80 39 00             	cmpb   $0x0,(%ecx)
 301:	75 f5                	jne    2f8 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
 303:	84 c0                	test   %al,%al
 305:	74 51                	je     358 <mystrcmp+0x78>
    int a =0,b=0;
 307:	31 f6                	xor    %esi,%esi
 309:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
 310:	83 c2 01             	add    $0x1,%edx
 313:	83 c6 01             	add    $0x1,%esi
 316:	80 3a 00             	cmpb   $0x0,(%edx)
 319:	75 f5                	jne    310 <mystrcmp+0x30>

    if(a!=b)return 0;
 31b:	31 c0                	xor    %eax,%eax
 31d:	39 de                	cmp    %ebx,%esi
 31f:	74 0f                	je     330 <mystrcmp+0x50>
    // printf("here");
    while(a--){
        if(*s1++ != *s2++)return 0;
    }
    return 1;
}
 321:	5b                   	pop    %ebx
 322:	5e                   	pop    %esi
 323:	5d                   	pop    %ebp
 324:	c3                   	ret    
 325:	8d 76 00             	lea    0x0(%esi),%esi
    while(*s2){b++;s2++;}
 328:	84 c0                	test   %al,%al
 32a:	75 db                	jne    307 <mystrcmp+0x27>
 32c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 330:	01 d3                	add    %edx,%ebx
 332:	eb 13                	jmp    347 <mystrcmp+0x67>
 334:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(*s1++ != *s2++)return 0;
 338:	83 c2 01             	add    $0x1,%edx
 33b:	83 c1 01             	add    $0x1,%ecx
 33e:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
 342:	38 41 ff             	cmp    %al,-0x1(%ecx)
 345:	75 11                	jne    358 <mystrcmp+0x78>
    while(a--){
 347:	39 d3                	cmp    %edx,%ebx
 349:	75 ed                	jne    338 <mystrcmp+0x58>
}
 34b:	5b                   	pop    %ebx
    return 1;
 34c:	b8 01 00 00 00       	mov    $0x1,%eax
}
 351:	5e                   	pop    %esi
 352:	5d                   	pop    %ebp
 353:	c3                   	ret    
 354:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 358:	5b                   	pop    %ebx
    if(a!=b)return 0;
 359:	31 c0                	xor    %eax,%eax
}
 35b:	5e                   	pop    %esi
 35c:	5d                   	pop    %ebp
 35d:	c3                   	ret    
 35e:	66 90                	xchg   %ax,%ax

00000360 <fmtname>:

char*
fmtname(char *path)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	53                   	push   %ebx
 365:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
 368:	83 ec 0c             	sub    $0xc,%esp
 36b:	53                   	push   %ebx
 36c:	e8 9f fd ff ff       	call   110 <strlen>
 371:	83 c4 10             	add    $0x10,%esp
 374:	01 d8                	add    %ebx,%eax
 376:	73 0f                	jae    387 <fmtname+0x27>
 378:	eb 12                	jmp    38c <fmtname+0x2c>
 37a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 380:	83 e8 01             	sub    $0x1,%eax
 383:	39 c3                	cmp    %eax,%ebx
 385:	77 05                	ja     38c <fmtname+0x2c>
 387:	80 38 2f             	cmpb   $0x2f,(%eax)
 38a:	75 f4                	jne    380 <fmtname+0x20>
    ;
  p++;
 38c:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
 38f:	83 ec 0c             	sub    $0xc,%esp
 392:	53                   	push   %ebx
 393:	e8 78 fd ff ff       	call   110 <strlen>
 398:	83 c4 10             	add    $0x10,%esp
 39b:	83 f8 0d             	cmp    $0xd,%eax
 39e:	77 4a                	ja     3ea <fmtname+0x8a>
    return p;
  memmove(buf, p, strlen(p));
 3a0:	83 ec 0c             	sub    $0xc,%esp
 3a3:	53                   	push   %ebx
 3a4:	e8 67 fd ff ff       	call   110 <strlen>
 3a9:	83 c4 0c             	add    $0xc,%esp
 3ac:	50                   	push   %eax
 3ad:	53                   	push   %ebx
 3ae:	68 60 0f 00 00       	push   $0xf60
 3b3:	e8 f8 fe ff ff       	call   2b0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 3b8:	89 1c 24             	mov    %ebx,(%esp)
 3bb:	e8 50 fd ff ff       	call   110 <strlen>
 3c0:	89 1c 24             	mov    %ebx,(%esp)
 3c3:	89 c6                	mov    %eax,%esi
  return buf;
 3c5:	bb 60 0f 00 00       	mov    $0xf60,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 3ca:	e8 41 fd ff ff       	call   110 <strlen>
 3cf:	ba 0e 00 00 00       	mov    $0xe,%edx
 3d4:	83 c4 0c             	add    $0xc,%esp
 3d7:	05 60 0f 00 00       	add    $0xf60,%eax
 3dc:	29 f2                	sub    %esi,%edx
 3de:	52                   	push   %edx
 3df:	6a 20                	push   $0x20
 3e1:	50                   	push   %eax
 3e2:	e8 59 fd ff ff       	call   140 <memset>
  return buf;
 3e7:	83 c4 10             	add    $0x10,%esp
}
 3ea:	8d 65 f8             	lea    -0x8(%ebp),%esp
 3ed:	89 d8                	mov    %ebx,%eax
 3ef:	5b                   	pop    %ebx
 3f0:	5e                   	pop    %esi
 3f1:	5d                   	pop    %ebp
 3f2:	c3                   	ret    
 3f3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 3f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000400 <ls>:

void
ls(char *path)
{
 400:	55                   	push   %ebp
 401:	89 e5                	mov    %esp,%ebp
 403:	57                   	push   %edi
 404:	56                   	push   %esi
 405:	53                   	push   %ebx
 406:	81 ec 5c 02 00 00    	sub    $0x25c,%esp

  int cid = getcid();
 40c:	e8 6d 03 00 00       	call   77e <getcid>

  printf(2, "Cid is: %d\n", cid);
 411:	83 ec 04             	sub    $0x4,%esp
  int cid = getcid();
 414:	89 c7                	mov    %eax,%edi
  printf(2, "Cid is: %d\n", cid);
 416:	50                   	push   %eax
 417:	68 a0 0b 00 00       	push   $0xba0
 41c:	6a 02                	push   $0x2
 41e:	e8 0d 04 00 00       	call   830 <printf>
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  if((fd = open(path, 0)) < 0){
 423:	59                   	pop    %ecx
 424:	5b                   	pop    %ebx
 425:	6a 00                	push   $0x0
 427:	ff 75 08             	pushl  0x8(%ebp)
 42a:	e8 a7 02 00 00       	call   6d6 <open>
 42f:	83 c4 10             	add    $0x10,%esp
 432:	85 c0                	test   %eax,%eax
 434:	78 5a                	js     490 <ls+0x90>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 436:	8d b5 d0 fd ff ff    	lea    -0x230(%ebp),%esi
 43c:	83 ec 08             	sub    $0x8,%esp
 43f:	89 c3                	mov    %eax,%ebx
 441:	56                   	push   %esi
 442:	50                   	push   %eax
 443:	e8 a6 02 00 00       	call   6ee <fstat>
 448:	83 c4 10             	add    $0x10,%esp
 44b:	85 c0                	test   %eax,%eax
 44d:	0f 88 cd 00 00 00    	js     520 <ls+0x120>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  switch(st.type){
 453:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 45a:	66 83 f8 01          	cmp    $0x1,%ax
 45e:	74 50                	je     4b0 <ls+0xb0>
 460:	66 83 f8 02          	cmp    $0x2,%ax
 464:	75 12                	jne    478 <ls+0x78>
  case T_FILE:
    if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 466:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 46c:	8d 42 01             	lea    0x1(%edx),%eax
 46f:	83 f8 01             	cmp    $0x1,%eax
 472:	76 6c                	jbe    4e0 <ls+0xe0>
 474:	39 fa                	cmp    %edi,%edx
 476:	74 68                	je     4e0 <ls+0xe0>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
    }
    break;
  }
  close(fd);
 478:	83 ec 0c             	sub    $0xc,%esp
 47b:	53                   	push   %ebx
 47c:	e8 3d 02 00 00       	call   6be <close>
 481:	83 c4 10             	add    $0x10,%esp

}
 484:	8d 65 f4             	lea    -0xc(%ebp),%esp
 487:	5b                   	pop    %ebx
 488:	5e                   	pop    %esi
 489:	5f                   	pop    %edi
 48a:	5d                   	pop    %ebp
 48b:	c3                   	ret    
 48c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
 490:	83 ec 04             	sub    $0x4,%esp
 493:	ff 75 08             	pushl  0x8(%ebp)
 496:	68 ac 0b 00 00       	push   $0xbac
 49b:	6a 02                	push   $0x2
 49d:	e8 8e 03 00 00       	call   830 <printf>
    return;
 4a2:	83 c4 10             	add    $0x10,%esp
}
 4a5:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4a8:	5b                   	pop    %ebx
 4a9:	5e                   	pop    %esi
 4aa:	5f                   	pop    %edi
 4ab:	5d                   	pop    %ebp
 4ac:	c3                   	ret    
 4ad:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 4b0:	83 ec 0c             	sub    $0xc,%esp
 4b3:	ff 75 08             	pushl  0x8(%ebp)
 4b6:	e8 55 fc ff ff       	call   110 <strlen>
 4bb:	83 c0 10             	add    $0x10,%eax
 4be:	83 c4 10             	add    $0x10,%esp
 4c1:	3d 00 02 00 00       	cmp    $0x200,%eax
 4c6:	0f 86 7c 00 00 00    	jbe    548 <ls+0x148>
      printf(1, "ls: path too long\n");
 4cc:	83 ec 08             	sub    $0x8,%esp
 4cf:	68 e4 0b 00 00       	push   $0xbe4
 4d4:	6a 01                	push   $0x1
 4d6:	e8 55 03 00 00       	call   830 <printf>
      break;
 4db:	83 c4 10             	add    $0x10,%esp
 4de:	eb 98                	jmp    478 <ls+0x78>
    printf(1, "%s %d %d %d %d\n", fmtname(path), st.type, st.ino, st.size, st.cid);
 4e0:	83 ec 0c             	sub    $0xc,%esp
 4e3:	ff 75 08             	pushl  0x8(%ebp)
 4e6:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 4ec:	8b bd e0 fd ff ff    	mov    -0x220(%ebp),%edi
 4f2:	8b b5 d8 fd ff ff    	mov    -0x228(%ebp),%esi
 4f8:	e8 63 fe ff ff       	call   360 <fmtname>
 4fd:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 503:	83 c4 0c             	add    $0xc,%esp
 506:	52                   	push   %edx
 507:	57                   	push   %edi
 508:	56                   	push   %esi
 509:	6a 02                	push   $0x2
 50b:	50                   	push   %eax
 50c:	68 d4 0b 00 00       	push   $0xbd4
 511:	6a 01                	push   $0x1
 513:	e8 18 03 00 00       	call   830 <printf>
    break;
 518:	83 c4 20             	add    $0x20,%esp
 51b:	e9 58 ff ff ff       	jmp    478 <ls+0x78>
    printf(2, "ls: cannot stat %s\n", path);
 520:	83 ec 04             	sub    $0x4,%esp
 523:	ff 75 08             	pushl  0x8(%ebp)
 526:	68 c0 0b 00 00       	push   $0xbc0
 52b:	6a 02                	push   $0x2
 52d:	e8 fe 02 00 00       	call   830 <printf>
    close(fd);
 532:	89 1c 24             	mov    %ebx,(%esp)
 535:	e8 84 01 00 00       	call   6be <close>
    return;
 53a:	83 c4 10             	add    $0x10,%esp
}
 53d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 540:	5b                   	pop    %ebx
 541:	5e                   	pop    %esi
 542:	5f                   	pop    %edi
 543:	5d                   	pop    %ebp
 544:	c3                   	ret    
 545:	8d 76 00             	lea    0x0(%esi),%esi
    strcpy(buf, path);
 548:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 54e:	83 ec 08             	sub    $0x8,%esp
 551:	ff 75 08             	pushl  0x8(%ebp)
 554:	50                   	push   %eax
 555:	e8 36 fb ff ff       	call   90 <strcpy>
    p = buf+strlen(buf);
 55a:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 560:	89 04 24             	mov    %eax,(%esp)
 563:	e8 a8 fb ff ff       	call   110 <strlen>
 568:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 56e:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 571:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 573:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 576:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 57c:	c6 00 2f             	movb   $0x2f,(%eax)
 57f:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 585:	8d 76 00             	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 588:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
 58e:	83 ec 04             	sub    $0x4,%esp
 591:	6a 10                	push   $0x10
 593:	50                   	push   %eax
 594:	53                   	push   %ebx
 595:	e8 14 01 00 00       	call   6ae <read>
 59a:	83 c4 10             	add    $0x10,%esp
 59d:	83 f8 10             	cmp    $0x10,%eax
 5a0:	0f 85 d2 fe ff ff    	jne    478 <ls+0x78>
      if(de.inum == 0)
 5a6:	66 83 bd c0 fd ff ff 	cmpw   $0x0,-0x240(%ebp)
 5ad:	00 
 5ae:	74 d8                	je     588 <ls+0x188>
      memmove(p, de.name, DIRSIZ);
 5b0:	8d 85 c2 fd ff ff    	lea    -0x23e(%ebp),%eax
 5b6:	83 ec 04             	sub    $0x4,%esp
 5b9:	6a 0e                	push   $0xe
 5bb:	50                   	push   %eax
 5bc:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 5c2:	e8 e9 fc ff ff       	call   2b0 <memmove>
      p[DIRSIZ] = 0;
 5c7:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 5cd:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 5d1:	58                   	pop    %eax
 5d2:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 5d8:	5a                   	pop    %edx
 5d9:	56                   	push   %esi
 5da:	50                   	push   %eax
 5db:	e8 40 fc ff ff       	call   220 <stat>
 5e0:	83 c4 10             	add    $0x10,%esp
 5e3:	85 c0                	test   %eax,%eax
 5e5:	0f 88 85 00 00 00    	js     670 <ls+0x270>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 5eb:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 5f1:	8d 42 01             	lea    0x1(%edx),%eax
 5f4:	83 f8 01             	cmp    $0x1,%eax
 5f7:	76 04                	jbe    5fd <ls+0x1fd>
 5f9:	39 fa                	cmp    %edi,%edx
 5fb:	75 8b                	jne    588 <ls+0x188>
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
 5fd:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
 603:	89 95 a0 fd ff ff    	mov    %edx,-0x260(%ebp)
 609:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 60f:	83 ec 0c             	sub    $0xc,%esp
 612:	8b 85 d8 fd ff ff    	mov    -0x228(%ebp),%eax
 618:	52                   	push   %edx
 619:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 61f:	0f bf 8d d0 fd ff ff 	movswl -0x230(%ebp),%ecx
 626:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 62c:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 632:	e8 29 fd ff ff       	call   360 <fmtname>
 637:	8b 95 a0 fd ff ff    	mov    -0x260(%ebp),%edx
 63d:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
 643:	83 c4 0c             	add    $0xc,%esp
 646:	52                   	push   %edx
 647:	51                   	push   %ecx
 648:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 64e:	ff b5 a8 fd ff ff    	pushl  -0x258(%ebp)
 654:	50                   	push   %eax
 655:	68 d4 0b 00 00       	push   $0xbd4
 65a:	6a 01                	push   $0x1
 65c:	e8 cf 01 00 00       	call   830 <printf>
 661:	83 c4 20             	add    $0x20,%esp
 664:	e9 1f ff ff ff       	jmp    588 <ls+0x188>
 669:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 670:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 676:	83 ec 04             	sub    $0x4,%esp
 679:	50                   	push   %eax
 67a:	68 c0 0b 00 00       	push   $0xbc0
 67f:	6a 01                	push   $0x1
 681:	e8 aa 01 00 00       	call   830 <printf>
        continue;
 686:	83 c4 10             	add    $0x10,%esp
 689:	e9 fa fe ff ff       	jmp    588 <ls+0x188>

0000068e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 68e:	b8 01 00 00 00       	mov    $0x1,%eax
 693:	cd 40                	int    $0x40
 695:	c3                   	ret    

00000696 <exit>:
SYSCALL(exit)
 696:	b8 02 00 00 00       	mov    $0x2,%eax
 69b:	cd 40                	int    $0x40
 69d:	c3                   	ret    

0000069e <wait>:
SYSCALL(wait)
 69e:	b8 03 00 00 00       	mov    $0x3,%eax
 6a3:	cd 40                	int    $0x40
 6a5:	c3                   	ret    

000006a6 <pipe>:
SYSCALL(pipe)
 6a6:	b8 04 00 00 00       	mov    $0x4,%eax
 6ab:	cd 40                	int    $0x40
 6ad:	c3                   	ret    

000006ae <read>:
SYSCALL(read)
 6ae:	b8 05 00 00 00       	mov    $0x5,%eax
 6b3:	cd 40                	int    $0x40
 6b5:	c3                   	ret    

000006b6 <write>:
SYSCALL(write)
 6b6:	b8 10 00 00 00       	mov    $0x10,%eax
 6bb:	cd 40                	int    $0x40
 6bd:	c3                   	ret    

000006be <close>:
SYSCALL(close)
 6be:	b8 15 00 00 00       	mov    $0x15,%eax
 6c3:	cd 40                	int    $0x40
 6c5:	c3                   	ret    

000006c6 <kill>:
SYSCALL(kill)
 6c6:	b8 06 00 00 00       	mov    $0x6,%eax
 6cb:	cd 40                	int    $0x40
 6cd:	c3                   	ret    

000006ce <exec>:
SYSCALL(exec)
 6ce:	b8 07 00 00 00       	mov    $0x7,%eax
 6d3:	cd 40                	int    $0x40
 6d5:	c3                   	ret    

000006d6 <open>:
SYSCALL(open)
 6d6:	b8 0f 00 00 00       	mov    $0xf,%eax
 6db:	cd 40                	int    $0x40
 6dd:	c3                   	ret    

000006de <mknod>:
SYSCALL(mknod)
 6de:	b8 11 00 00 00       	mov    $0x11,%eax
 6e3:	cd 40                	int    $0x40
 6e5:	c3                   	ret    

000006e6 <unlink>:
SYSCALL(unlink)
 6e6:	b8 12 00 00 00       	mov    $0x12,%eax
 6eb:	cd 40                	int    $0x40
 6ed:	c3                   	ret    

000006ee <fstat>:
SYSCALL(fstat)
 6ee:	b8 08 00 00 00       	mov    $0x8,%eax
 6f3:	cd 40                	int    $0x40
 6f5:	c3                   	ret    

000006f6 <link>:
SYSCALL(link)
 6f6:	b8 13 00 00 00       	mov    $0x13,%eax
 6fb:	cd 40                	int    $0x40
 6fd:	c3                   	ret    

000006fe <mkdir>:
SYSCALL(mkdir)
 6fe:	b8 14 00 00 00       	mov    $0x14,%eax
 703:	cd 40                	int    $0x40
 705:	c3                   	ret    

00000706 <chdir>:
SYSCALL(chdir)
 706:	b8 09 00 00 00       	mov    $0x9,%eax
 70b:	cd 40                	int    $0x40
 70d:	c3                   	ret    

0000070e <dup>:
SYSCALL(dup)
 70e:	b8 0a 00 00 00       	mov    $0xa,%eax
 713:	cd 40                	int    $0x40
 715:	c3                   	ret    

00000716 <getpid>:
SYSCALL(getpid)
 716:	b8 0b 00 00 00       	mov    $0xb,%eax
 71b:	cd 40                	int    $0x40
 71d:	c3                   	ret    

0000071e <sbrk>:
SYSCALL(sbrk)
 71e:	b8 0c 00 00 00       	mov    $0xc,%eax
 723:	cd 40                	int    $0x40
 725:	c3                   	ret    

00000726 <sleep>:
SYSCALL(sleep)
 726:	b8 0d 00 00 00       	mov    $0xd,%eax
 72b:	cd 40                	int    $0x40
 72d:	c3                   	ret    

0000072e <uptime>:
SYSCALL(uptime)
 72e:	b8 0e 00 00 00       	mov    $0xe,%eax
 733:	cd 40                	int    $0x40
 735:	c3                   	ret    

00000736 <halt>:
SYSCALL(halt)
 736:	b8 16 00 00 00       	mov    $0x16,%eax
 73b:	cd 40                	int    $0x40
 73d:	c3                   	ret    

0000073e <toggle>:
SYSCALL(toggle)
 73e:	b8 17 00 00 00       	mov    $0x17,%eax
 743:	cd 40                	int    $0x40
 745:	c3                   	ret    

00000746 <ps>:
SYSCALL(ps)
 746:	b8 18 00 00 00       	mov    $0x18,%eax
 74b:	cd 40                	int    $0x40
 74d:	c3                   	ret    

0000074e <create_container>:
SYSCALL(create_container)
 74e:	b8 1c 00 00 00       	mov    $0x1c,%eax
 753:	cd 40                	int    $0x40
 755:	c3                   	ret    

00000756 <destroy_container>:
SYSCALL(destroy_container)
 756:	b8 19 00 00 00       	mov    $0x19,%eax
 75b:	cd 40                	int    $0x40
 75d:	c3                   	ret    

0000075e <join_container>:
SYSCALL(join_container)
 75e:	b8 1a 00 00 00       	mov    $0x1a,%eax
 763:	cd 40                	int    $0x40
 765:	c3                   	ret    

00000766 <leave_container>:
SYSCALL(leave_container)
 766:	b8 1b 00 00 00       	mov    $0x1b,%eax
 76b:	cd 40                	int    $0x40
 76d:	c3                   	ret    

0000076e <send>:
SYSCALL(send)
 76e:	b8 1d 00 00 00       	mov    $0x1d,%eax
 773:	cd 40                	int    $0x40
 775:	c3                   	ret    

00000776 <recv>:
SYSCALL(recv)
 776:	b8 1e 00 00 00       	mov    $0x1e,%eax
 77b:	cd 40                	int    $0x40
 77d:	c3                   	ret    

0000077e <getcid>:
SYSCALL(getcid)
 77e:	b8 1f 00 00 00       	mov    $0x1f,%eax
 783:	cd 40                	int    $0x40
 785:	c3                   	ret    
 786:	66 90                	xchg   %ax,%ax
 788:	66 90                	xchg   %ax,%ax
 78a:	66 90                	xchg   %ax,%ax
 78c:	66 90                	xchg   %ax,%ax
 78e:	66 90                	xchg   %ax,%ax

00000790 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 790:	55                   	push   %ebp
 791:	89 e5                	mov    %esp,%ebp
 793:	57                   	push   %edi
 794:	56                   	push   %esi
 795:	53                   	push   %ebx
 796:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 799:	85 d2                	test   %edx,%edx
{
 79b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 79e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 7a0:	79 76                	jns    818 <printint+0x88>
 7a2:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 7a6:	74 70                	je     818 <printint+0x88>
    x = -xx;
 7a8:	f7 d8                	neg    %eax
    neg = 1;
 7aa:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 7b1:	31 f6                	xor    %esi,%esi
 7b3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 7b6:	eb 0a                	jmp    7c2 <printint+0x32>
 7b8:	90                   	nop
 7b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 7c0:	89 fe                	mov    %edi,%esi
 7c2:	31 d2                	xor    %edx,%edx
 7c4:	8d 7e 01             	lea    0x1(%esi),%edi
 7c7:	f7 f1                	div    %ecx
 7c9:	0f b6 92 00 0c 00 00 	movzbl 0xc00(%edx),%edx
  }while((x /= base) != 0);
 7d0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 7d2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 7d5:	75 e9                	jne    7c0 <printint+0x30>
  if(neg)
 7d7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 7da:	85 c0                	test   %eax,%eax
 7dc:	74 08                	je     7e6 <printint+0x56>
    buf[i++] = '-';
 7de:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 7e3:	8d 7e 02             	lea    0x2(%esi),%edi
 7e6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 7ea:	8b 7d c0             	mov    -0x40(%ebp),%edi
 7ed:	8d 76 00             	lea    0x0(%esi),%esi
 7f0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 7f3:	83 ec 04             	sub    $0x4,%esp
 7f6:	83 ee 01             	sub    $0x1,%esi
 7f9:	6a 01                	push   $0x1
 7fb:	53                   	push   %ebx
 7fc:	57                   	push   %edi
 7fd:	88 45 d7             	mov    %al,-0x29(%ebp)
 800:	e8 b1 fe ff ff       	call   6b6 <write>

  while(--i >= 0)
 805:	83 c4 10             	add    $0x10,%esp
 808:	39 de                	cmp    %ebx,%esi
 80a:	75 e4                	jne    7f0 <printint+0x60>
    putc(fd, buf[i]);
}
 80c:	8d 65 f4             	lea    -0xc(%ebp),%esp
 80f:	5b                   	pop    %ebx
 810:	5e                   	pop    %esi
 811:	5f                   	pop    %edi
 812:	5d                   	pop    %ebp
 813:	c3                   	ret    
 814:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 818:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 81f:	eb 90                	jmp    7b1 <printint+0x21>
 821:	eb 0d                	jmp    830 <printf>
 823:	90                   	nop
 824:	90                   	nop
 825:	90                   	nop
 826:	90                   	nop
 827:	90                   	nop
 828:	90                   	nop
 829:	90                   	nop
 82a:	90                   	nop
 82b:	90                   	nop
 82c:	90                   	nop
 82d:	90                   	nop
 82e:	90                   	nop
 82f:	90                   	nop

00000830 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 830:	55                   	push   %ebp
 831:	89 e5                	mov    %esp,%ebp
 833:	57                   	push   %edi
 834:	56                   	push   %esi
 835:	53                   	push   %ebx
 836:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 839:	8b 75 0c             	mov    0xc(%ebp),%esi
 83c:	0f b6 1e             	movzbl (%esi),%ebx
 83f:	84 db                	test   %bl,%bl
 841:	0f 84 b3 00 00 00    	je     8fa <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 847:	8d 45 10             	lea    0x10(%ebp),%eax
 84a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 84d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 84f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 852:	eb 2f                	jmp    883 <printf+0x53>
 854:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 858:	83 f8 25             	cmp    $0x25,%eax
 85b:	0f 84 a7 00 00 00    	je     908 <printf+0xd8>
  write(fd, &c, 1);
 861:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 864:	83 ec 04             	sub    $0x4,%esp
 867:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 86a:	6a 01                	push   $0x1
 86c:	50                   	push   %eax
 86d:	ff 75 08             	pushl  0x8(%ebp)
 870:	e8 41 fe ff ff       	call   6b6 <write>
 875:	83 c4 10             	add    $0x10,%esp
 878:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 87b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 87f:	84 db                	test   %bl,%bl
 881:	74 77                	je     8fa <printf+0xca>
    if(state == 0){
 883:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 885:	0f be cb             	movsbl %bl,%ecx
 888:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 88b:	74 cb                	je     858 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 88d:	83 ff 25             	cmp    $0x25,%edi
 890:	75 e6                	jne    878 <printf+0x48>
      if(c == 'd'){
 892:	83 f8 64             	cmp    $0x64,%eax
 895:	0f 84 05 01 00 00    	je     9a0 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 89b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 8a1:	83 f9 70             	cmp    $0x70,%ecx
 8a4:	74 72                	je     918 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 8a6:	83 f8 73             	cmp    $0x73,%eax
 8a9:	0f 84 99 00 00 00    	je     948 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 8af:	83 f8 63             	cmp    $0x63,%eax
 8b2:	0f 84 08 01 00 00    	je     9c0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 8b8:	83 f8 25             	cmp    $0x25,%eax
 8bb:	0f 84 ef 00 00 00    	je     9b0 <printf+0x180>
  write(fd, &c, 1);
 8c1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 8c4:	83 ec 04             	sub    $0x4,%esp
 8c7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 8cb:	6a 01                	push   $0x1
 8cd:	50                   	push   %eax
 8ce:	ff 75 08             	pushl  0x8(%ebp)
 8d1:	e8 e0 fd ff ff       	call   6b6 <write>
 8d6:	83 c4 0c             	add    $0xc,%esp
 8d9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 8dc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 8df:	6a 01                	push   $0x1
 8e1:	50                   	push   %eax
 8e2:	ff 75 08             	pushl  0x8(%ebp)
 8e5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 8e8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 8ea:	e8 c7 fd ff ff       	call   6b6 <write>
  for(i = 0; fmt[i]; i++){
 8ef:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 8f3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 8f6:	84 db                	test   %bl,%bl
 8f8:	75 89                	jne    883 <printf+0x53>
    }
  }
}
 8fa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8fd:	5b                   	pop    %ebx
 8fe:	5e                   	pop    %esi
 8ff:	5f                   	pop    %edi
 900:	5d                   	pop    %ebp
 901:	c3                   	ret    
 902:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 908:	bf 25 00 00 00       	mov    $0x25,%edi
 90d:	e9 66 ff ff ff       	jmp    878 <printf+0x48>
 912:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 918:	83 ec 0c             	sub    $0xc,%esp
 91b:	b9 10 00 00 00       	mov    $0x10,%ecx
 920:	6a 00                	push   $0x0
 922:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 925:	8b 45 08             	mov    0x8(%ebp),%eax
 928:	8b 17                	mov    (%edi),%edx
 92a:	e8 61 fe ff ff       	call   790 <printint>
        ap++;
 92f:	89 f8                	mov    %edi,%eax
 931:	83 c4 10             	add    $0x10,%esp
      state = 0;
 934:	31 ff                	xor    %edi,%edi
        ap++;
 936:	83 c0 04             	add    $0x4,%eax
 939:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 93c:	e9 37 ff ff ff       	jmp    878 <printf+0x48>
 941:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 948:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 94b:	8b 08                	mov    (%eax),%ecx
        ap++;
 94d:	83 c0 04             	add    $0x4,%eax
 950:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 953:	85 c9                	test   %ecx,%ecx
 955:	0f 84 8e 00 00 00    	je     9e9 <printf+0x1b9>
        while(*s != 0){
 95b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 95e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 960:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 962:	84 c0                	test   %al,%al
 964:	0f 84 0e ff ff ff    	je     878 <printf+0x48>
 96a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 96d:	89 de                	mov    %ebx,%esi
 96f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 972:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 975:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 978:	83 ec 04             	sub    $0x4,%esp
          s++;
 97b:	83 c6 01             	add    $0x1,%esi
 97e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 981:	6a 01                	push   $0x1
 983:	57                   	push   %edi
 984:	53                   	push   %ebx
 985:	e8 2c fd ff ff       	call   6b6 <write>
        while(*s != 0){
 98a:	0f b6 06             	movzbl (%esi),%eax
 98d:	83 c4 10             	add    $0x10,%esp
 990:	84 c0                	test   %al,%al
 992:	75 e4                	jne    978 <printf+0x148>
 994:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 997:	31 ff                	xor    %edi,%edi
 999:	e9 da fe ff ff       	jmp    878 <printf+0x48>
 99e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 9a0:	83 ec 0c             	sub    $0xc,%esp
 9a3:	b9 0a 00 00 00       	mov    $0xa,%ecx
 9a8:	6a 01                	push   $0x1
 9aa:	e9 73 ff ff ff       	jmp    922 <printf+0xf2>
 9af:	90                   	nop
  write(fd, &c, 1);
 9b0:	83 ec 04             	sub    $0x4,%esp
 9b3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 9b6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 9b9:	6a 01                	push   $0x1
 9bb:	e9 21 ff ff ff       	jmp    8e1 <printf+0xb1>
        putc(fd, *ap);
 9c0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 9c3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 9c6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 9c8:	6a 01                	push   $0x1
        ap++;
 9ca:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 9cd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 9d0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 9d3:	50                   	push   %eax
 9d4:	ff 75 08             	pushl  0x8(%ebp)
 9d7:	e8 da fc ff ff       	call   6b6 <write>
        ap++;
 9dc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 9df:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9e2:	31 ff                	xor    %edi,%edi
 9e4:	e9 8f fe ff ff       	jmp    878 <printf+0x48>
          s = "(null)";
 9e9:	bb f7 0b 00 00       	mov    $0xbf7,%ebx
        while(*s != 0){
 9ee:	b8 28 00 00 00       	mov    $0x28,%eax
 9f3:	e9 72 ff ff ff       	jmp    96a <printf+0x13a>
 9f8:	66 90                	xchg   %ax,%ax
 9fa:	66 90                	xchg   %ax,%ax
 9fc:	66 90                	xchg   %ax,%ax
 9fe:	66 90                	xchg   %ax,%ax

00000a00 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 a00:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a01:	a1 70 0f 00 00       	mov    0xf70,%eax
{
 a06:	89 e5                	mov    %esp,%ebp
 a08:	57                   	push   %edi
 a09:	56                   	push   %esi
 a0a:	53                   	push   %ebx
 a0b:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 a0e:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 a11:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 a18:	39 c8                	cmp    %ecx,%eax
 a1a:	8b 10                	mov    (%eax),%edx
 a1c:	73 32                	jae    a50 <free+0x50>
 a1e:	39 d1                	cmp    %edx,%ecx
 a20:	72 04                	jb     a26 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a22:	39 d0                	cmp    %edx,%eax
 a24:	72 32                	jb     a58 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 a26:	8b 73 fc             	mov    -0x4(%ebx),%esi
 a29:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 a2c:	39 fa                	cmp    %edi,%edx
 a2e:	74 30                	je     a60 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 a30:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a33:	8b 50 04             	mov    0x4(%eax),%edx
 a36:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a39:	39 f1                	cmp    %esi,%ecx
 a3b:	74 3a                	je     a77 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 a3d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 a3f:	a3 70 0f 00 00       	mov    %eax,0xf70
}
 a44:	5b                   	pop    %ebx
 a45:	5e                   	pop    %esi
 a46:	5f                   	pop    %edi
 a47:	5d                   	pop    %ebp
 a48:	c3                   	ret    
 a49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 a50:	39 d0                	cmp    %edx,%eax
 a52:	72 04                	jb     a58 <free+0x58>
 a54:	39 d1                	cmp    %edx,%ecx
 a56:	72 ce                	jb     a26 <free+0x26>
{
 a58:	89 d0                	mov    %edx,%eax
 a5a:	eb bc                	jmp    a18 <free+0x18>
 a5c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 a60:	03 72 04             	add    0x4(%edx),%esi
 a63:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a66:	8b 10                	mov    (%eax),%edx
 a68:	8b 12                	mov    (%edx),%edx
 a6a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a6d:	8b 50 04             	mov    0x4(%eax),%edx
 a70:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a73:	39 f1                	cmp    %esi,%ecx
 a75:	75 c6                	jne    a3d <free+0x3d>
    p->s.size += bp->s.size;
 a77:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 a7a:	a3 70 0f 00 00       	mov    %eax,0xf70
    p->s.size += bp->s.size;
 a7f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a82:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a85:	89 10                	mov    %edx,(%eax)
}
 a87:	5b                   	pop    %ebx
 a88:	5e                   	pop    %esi
 a89:	5f                   	pop    %edi
 a8a:	5d                   	pop    %ebp
 a8b:	c3                   	ret    
 a8c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a90 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a90:	55                   	push   %ebp
 a91:	89 e5                	mov    %esp,%ebp
 a93:	57                   	push   %edi
 a94:	56                   	push   %esi
 a95:	53                   	push   %ebx
 a96:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a99:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a9c:	8b 15 70 0f 00 00    	mov    0xf70,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 aa2:	8d 78 07             	lea    0x7(%eax),%edi
 aa5:	c1 ef 03             	shr    $0x3,%edi
 aa8:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 aab:	85 d2                	test   %edx,%edx
 aad:	0f 84 9d 00 00 00    	je     b50 <malloc+0xc0>
 ab3:	8b 02                	mov    (%edx),%eax
 ab5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 ab8:	39 cf                	cmp    %ecx,%edi
 aba:	76 6c                	jbe    b28 <malloc+0x98>
 abc:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 ac2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 ac7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 aca:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 ad1:	eb 0e                	jmp    ae1 <malloc+0x51>
 ad3:	90                   	nop
 ad4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 ad8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 ada:	8b 48 04             	mov    0x4(%eax),%ecx
 add:	39 f9                	cmp    %edi,%ecx
 adf:	73 47                	jae    b28 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 ae1:	39 05 70 0f 00 00    	cmp    %eax,0xf70
 ae7:	89 c2                	mov    %eax,%edx
 ae9:	75 ed                	jne    ad8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 aeb:	83 ec 0c             	sub    $0xc,%esp
 aee:	56                   	push   %esi
 aef:	e8 2a fc ff ff       	call   71e <sbrk>
  if(p == (char*)-1)
 af4:	83 c4 10             	add    $0x10,%esp
 af7:	83 f8 ff             	cmp    $0xffffffff,%eax
 afa:	74 1c                	je     b18 <malloc+0x88>
  hp->s.size = nu;
 afc:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 aff:	83 ec 0c             	sub    $0xc,%esp
 b02:	83 c0 08             	add    $0x8,%eax
 b05:	50                   	push   %eax
 b06:	e8 f5 fe ff ff       	call   a00 <free>
  return freep;
 b0b:	8b 15 70 0f 00 00    	mov    0xf70,%edx
      if((p = morecore(nunits)) == 0)
 b11:	83 c4 10             	add    $0x10,%esp
 b14:	85 d2                	test   %edx,%edx
 b16:	75 c0                	jne    ad8 <malloc+0x48>
        return 0;
  }
}
 b18:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 b1b:	31 c0                	xor    %eax,%eax
}
 b1d:	5b                   	pop    %ebx
 b1e:	5e                   	pop    %esi
 b1f:	5f                   	pop    %edi
 b20:	5d                   	pop    %ebp
 b21:	c3                   	ret    
 b22:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 b28:	39 cf                	cmp    %ecx,%edi
 b2a:	74 54                	je     b80 <malloc+0xf0>
        p->s.size -= nunits;
 b2c:	29 f9                	sub    %edi,%ecx
 b2e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 b31:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 b34:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 b37:	89 15 70 0f 00 00    	mov    %edx,0xf70
}
 b3d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 b40:	83 c0 08             	add    $0x8,%eax
}
 b43:	5b                   	pop    %ebx
 b44:	5e                   	pop    %esi
 b45:	5f                   	pop    %edi
 b46:	5d                   	pop    %ebp
 b47:	c3                   	ret    
 b48:	90                   	nop
 b49:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 b50:	c7 05 70 0f 00 00 74 	movl   $0xf74,0xf70
 b57:	0f 00 00 
 b5a:	c7 05 74 0f 00 00 74 	movl   $0xf74,0xf74
 b61:	0f 00 00 
    base.s.size = 0;
 b64:	b8 74 0f 00 00       	mov    $0xf74,%eax
 b69:	c7 05 78 0f 00 00 00 	movl   $0x0,0xf78
 b70:	00 00 00 
 b73:	e9 44 ff ff ff       	jmp    abc <malloc+0x2c>
 b78:	90                   	nop
 b79:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 b80:	8b 08                	mov    (%eax),%ecx
 b82:	89 0a                	mov    %ecx,(%edx)
 b84:	eb b1                	jmp    b37 <malloc+0xa7>
