
_container:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "user.h"
#include "date.h"

int
main ( int argc , char * argv [])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	51                   	push   %ecx
   e:	83 ec 10             	sub    $0x10,%esp
  11:	8b 41 04             	mov    0x4(%ecx),%eax

create_container((int)*argv[1]);
  14:	8b 40 04             	mov    0x4(%eax),%eax
  17:	0f be 00             	movsbl (%eax),%eax
  1a:	50                   	push   %eax
  1b:	e8 ce 06 00 00       	call   6ee <create_container>
exit();
  20:	e8 11 06 00 00       	call   636 <exit>
  25:	66 90                	xchg   %ax,%ax
  27:	66 90                	xchg   %ax,%ax
  29:	66 90                	xchg   %ax,%ax
  2b:	66 90                	xchg   %ax,%ax
  2d:	66 90                	xchg   %ax,%ax
  2f:	90                   	nop

00000030 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
  30:	55                   	push   %ebp
  31:	89 e5                	mov    %esp,%ebp
  33:	53                   	push   %ebx
  34:	8b 45 08             	mov    0x8(%ebp),%eax
  37:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
  3a:	89 c2                	mov    %eax,%edx
  3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  40:	83 c1 01             	add    $0x1,%ecx
  43:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
  47:	83 c2 01             	add    $0x1,%edx
  4a:	84 db                	test   %bl,%bl
  4c:	88 5a ff             	mov    %bl,-0x1(%edx)
  4f:	75 ef                	jne    40 <strcpy+0x10>
    ;
  return os;
}
  51:	5b                   	pop    %ebx
  52:	5d                   	pop    %ebp
  53:	c3                   	ret    
  54:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  5a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000060 <strcmp>:

int
strcmp(const char *p, const char *q)
{
  60:	55                   	push   %ebp
  61:	89 e5                	mov    %esp,%ebp
  63:	53                   	push   %ebx
  64:	8b 55 08             	mov    0x8(%ebp),%edx
  67:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
  6a:	0f b6 02             	movzbl (%edx),%eax
  6d:	0f b6 19             	movzbl (%ecx),%ebx
  70:	84 c0                	test   %al,%al
  72:	75 1c                	jne    90 <strcmp+0x30>
  74:	eb 2a                	jmp    a0 <strcmp+0x40>
  76:	8d 76 00             	lea    0x0(%esi),%esi
  79:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
  80:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
  83:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
  86:	83 c1 01             	add    $0x1,%ecx
  89:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
  8c:	84 c0                	test   %al,%al
  8e:	74 10                	je     a0 <strcmp+0x40>
  90:	38 d8                	cmp    %bl,%al
  92:	74 ec                	je     80 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
  94:	29 d8                	sub    %ebx,%eax
}
  96:	5b                   	pop    %ebx
  97:	5d                   	pop    %ebp
  98:	c3                   	ret    
  99:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  a0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
  a2:	29 d8                	sub    %ebx,%eax
}
  a4:	5b                   	pop    %ebx
  a5:	5d                   	pop    %ebp
  a6:	c3                   	ret    
  a7:	89 f6                	mov    %esi,%esi
  a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000000b0 <strlen>:

uint
strlen(const char *s)
{
  b0:	55                   	push   %ebp
  b1:	89 e5                	mov    %esp,%ebp
  b3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
  b6:	80 39 00             	cmpb   $0x0,(%ecx)
  b9:	74 15                	je     d0 <strlen+0x20>
  bb:	31 d2                	xor    %edx,%edx
  bd:	8d 76 00             	lea    0x0(%esi),%esi
  c0:	83 c2 01             	add    $0x1,%edx
  c3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
  c7:	89 d0                	mov    %edx,%eax
  c9:	75 f5                	jne    c0 <strlen+0x10>
    ;
  return n;
}
  cb:	5d                   	pop    %ebp
  cc:	c3                   	ret    
  cd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
  d0:	31 c0                	xor    %eax,%eax
}
  d2:	5d                   	pop    %ebp
  d3:	c3                   	ret    
  d4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
  da:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000000e0 <memset>:

void*
memset(void *dst, int c, uint n)
{
  e0:	55                   	push   %ebp
  e1:	89 e5                	mov    %esp,%ebp
  e3:	57                   	push   %edi
  e4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
  e7:	8b 4d 10             	mov    0x10(%ebp),%ecx
  ea:	8b 45 0c             	mov    0xc(%ebp),%eax
  ed:	89 d7                	mov    %edx,%edi
  ef:	fc                   	cld    
  f0:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
  f2:	89 d0                	mov    %edx,%eax
  f4:	5f                   	pop    %edi
  f5:	5d                   	pop    %ebp
  f6:	c3                   	ret    
  f7:	89 f6                	mov    %esi,%esi
  f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000100 <strchr>:

char*
strchr(const char *s, char c)
{
 100:	55                   	push   %ebp
 101:	89 e5                	mov    %esp,%ebp
 103:	53                   	push   %ebx
 104:	8b 45 08             	mov    0x8(%ebp),%eax
 107:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 10a:	0f b6 10             	movzbl (%eax),%edx
 10d:	84 d2                	test   %dl,%dl
 10f:	74 1d                	je     12e <strchr+0x2e>
    if(*s == c)
 111:	38 d3                	cmp    %dl,%bl
 113:	89 d9                	mov    %ebx,%ecx
 115:	75 0d                	jne    124 <strchr+0x24>
 117:	eb 17                	jmp    130 <strchr+0x30>
 119:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 120:	38 ca                	cmp    %cl,%dl
 122:	74 0c                	je     130 <strchr+0x30>
  for(; *s; s++)
 124:	83 c0 01             	add    $0x1,%eax
 127:	0f b6 10             	movzbl (%eax),%edx
 12a:	84 d2                	test   %dl,%dl
 12c:	75 f2                	jne    120 <strchr+0x20>
      return (char*)s;
  return 0;
 12e:	31 c0                	xor    %eax,%eax
}
 130:	5b                   	pop    %ebx
 131:	5d                   	pop    %ebp
 132:	c3                   	ret    
 133:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 139:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000140 <gets>:

char*
gets(char *buf, int max)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	57                   	push   %edi
 144:	56                   	push   %esi
 145:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 146:	31 f6                	xor    %esi,%esi
 148:	89 f3                	mov    %esi,%ebx
{
 14a:	83 ec 1c             	sub    $0x1c,%esp
 14d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 150:	eb 2f                	jmp    181 <gets+0x41>
 152:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 158:	8d 45 e7             	lea    -0x19(%ebp),%eax
 15b:	83 ec 04             	sub    $0x4,%esp
 15e:	6a 01                	push   $0x1
 160:	50                   	push   %eax
 161:	6a 00                	push   $0x0
 163:	e8 e6 04 00 00       	call   64e <read>
    if(cc < 1)
 168:	83 c4 10             	add    $0x10,%esp
 16b:	85 c0                	test   %eax,%eax
 16d:	7e 1c                	jle    18b <gets+0x4b>
      break;
    buf[i++] = c;
 16f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 173:	83 c7 01             	add    $0x1,%edi
 176:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 179:	3c 0a                	cmp    $0xa,%al
 17b:	74 23                	je     1a0 <gets+0x60>
 17d:	3c 0d                	cmp    $0xd,%al
 17f:	74 1f                	je     1a0 <gets+0x60>
  for(i=0; i+1 < max; ){
 181:	83 c3 01             	add    $0x1,%ebx
 184:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 187:	89 fe                	mov    %edi,%esi
 189:	7c cd                	jl     158 <gets+0x18>
 18b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 18d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 190:	c6 03 00             	movb   $0x0,(%ebx)
}
 193:	8d 65 f4             	lea    -0xc(%ebp),%esp
 196:	5b                   	pop    %ebx
 197:	5e                   	pop    %esi
 198:	5f                   	pop    %edi
 199:	5d                   	pop    %ebp
 19a:	c3                   	ret    
 19b:	90                   	nop
 19c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1a0:	8b 75 08             	mov    0x8(%ebp),%esi
 1a3:	8b 45 08             	mov    0x8(%ebp),%eax
 1a6:	01 de                	add    %ebx,%esi
 1a8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 1aa:	c6 03 00             	movb   $0x0,(%ebx)
}
 1ad:	8d 65 f4             	lea    -0xc(%ebp),%esp
 1b0:	5b                   	pop    %ebx
 1b1:	5e                   	pop    %esi
 1b2:	5f                   	pop    %edi
 1b3:	5d                   	pop    %ebp
 1b4:	c3                   	ret    
 1b5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <stat>:

int
stat(const char *n, struct stat *st)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	56                   	push   %esi
 1c4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 1c5:	83 ec 08             	sub    $0x8,%esp
 1c8:	6a 00                	push   $0x0
 1ca:	ff 75 08             	pushl  0x8(%ebp)
 1cd:	e8 a4 04 00 00       	call   676 <open>
  if(fd < 0)
 1d2:	83 c4 10             	add    $0x10,%esp
 1d5:	85 c0                	test   %eax,%eax
 1d7:	78 27                	js     200 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 1d9:	83 ec 08             	sub    $0x8,%esp
 1dc:	ff 75 0c             	pushl  0xc(%ebp)
 1df:	89 c3                	mov    %eax,%ebx
 1e1:	50                   	push   %eax
 1e2:	e8 a7 04 00 00       	call   68e <fstat>
  close(fd);
 1e7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 1ea:	89 c6                	mov    %eax,%esi
  close(fd);
 1ec:	e8 6d 04 00 00       	call   65e <close>
  return r;
 1f1:	83 c4 10             	add    $0x10,%esp
}
 1f4:	8d 65 f8             	lea    -0x8(%ebp),%esp
 1f7:	89 f0                	mov    %esi,%eax
 1f9:	5b                   	pop    %ebx
 1fa:	5e                   	pop    %esi
 1fb:	5d                   	pop    %ebp
 1fc:	c3                   	ret    
 1fd:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 200:	be ff ff ff ff       	mov    $0xffffffff,%esi
 205:	eb ed                	jmp    1f4 <stat+0x34>
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <atoi>:

int
atoi(const char *s)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 217:	0f be 11             	movsbl (%ecx),%edx
 21a:	8d 42 d0             	lea    -0x30(%edx),%eax
 21d:	3c 09                	cmp    $0x9,%al
  n = 0;
 21f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 224:	77 1f                	ja     245 <atoi+0x35>
 226:	8d 76 00             	lea    0x0(%esi),%esi
 229:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 230:	8d 04 80             	lea    (%eax,%eax,4),%eax
 233:	83 c1 01             	add    $0x1,%ecx
 236:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 23a:	0f be 11             	movsbl (%ecx),%edx
 23d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 240:	80 fb 09             	cmp    $0x9,%bl
 243:	76 eb                	jbe    230 <atoi+0x20>
  return n;
}
 245:	5b                   	pop    %ebx
 246:	5d                   	pop    %ebp
 247:	c3                   	ret    
 248:	90                   	nop
 249:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000250 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	56                   	push   %esi
 254:	53                   	push   %ebx
 255:	8b 5d 10             	mov    0x10(%ebp),%ebx
 258:	8b 45 08             	mov    0x8(%ebp),%eax
 25b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 25e:	85 db                	test   %ebx,%ebx
 260:	7e 14                	jle    276 <memmove+0x26>
 262:	31 d2                	xor    %edx,%edx
 264:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 268:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 26c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 26f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 272:	39 d3                	cmp    %edx,%ebx
 274:	75 f2                	jne    268 <memmove+0x18>
  return vdst;
}
 276:	5b                   	pop    %ebx
 277:	5e                   	pop    %esi
 278:	5d                   	pop    %ebp
 279:	c3                   	ret    
 27a:	66 90                	xchg   %ax,%ax
 27c:	66 90                	xchg   %ax,%ax
 27e:	66 90                	xchg   %ax,%ax

00000280 <mystrcmp>:
#include "ls.h"
// #include "defs.h"

int
mystrcmp (char *s1, char *s2)
{
 280:	55                   	push   %ebp
 281:	89 e5                	mov    %esp,%ebp
 283:	56                   	push   %esi
 284:	53                   	push   %ebx
 285:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int a =0,b=0;
 288:	31 db                	xor    %ebx,%ebx
{
 28a:	8b 55 0c             	mov    0xc(%ebp),%edx
    while(*s1){a++;s1++;}
 28d:	80 39 00             	cmpb   $0x0,(%ecx)
 290:	0f b6 02             	movzbl (%edx),%eax
 293:	74 33                	je     2c8 <mystrcmp+0x48>
 295:	8d 76 00             	lea    0x0(%esi),%esi
 298:	83 c1 01             	add    $0x1,%ecx
 29b:	83 c3 01             	add    $0x1,%ebx
 29e:	80 39 00             	cmpb   $0x0,(%ecx)
 2a1:	75 f5                	jne    298 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
 2a3:	84 c0                	test   %al,%al
 2a5:	74 51                	je     2f8 <mystrcmp+0x78>
    int a =0,b=0;
 2a7:	31 f6                	xor    %esi,%esi
 2a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
 2b0:	83 c2 01             	add    $0x1,%edx
 2b3:	83 c6 01             	add    $0x1,%esi
 2b6:	80 3a 00             	cmpb   $0x0,(%edx)
 2b9:	75 f5                	jne    2b0 <mystrcmp+0x30>

    if(a!=b)return 0;
 2bb:	31 c0                	xor    %eax,%eax
 2bd:	39 de                	cmp    %ebx,%esi
 2bf:	74 0f                	je     2d0 <mystrcmp+0x50>
    // printf("here");
    while(a--){
        if(*s1++ != *s2++)return 0;
    }
    return 1;
}
 2c1:	5b                   	pop    %ebx
 2c2:	5e                   	pop    %esi
 2c3:	5d                   	pop    %ebp
 2c4:	c3                   	ret    
 2c5:	8d 76 00             	lea    0x0(%esi),%esi
    while(*s2){b++;s2++;}
 2c8:	84 c0                	test   %al,%al
 2ca:	75 db                	jne    2a7 <mystrcmp+0x27>
 2cc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2d0:	01 d3                	add    %edx,%ebx
 2d2:	eb 13                	jmp    2e7 <mystrcmp+0x67>
 2d4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(*s1++ != *s2++)return 0;
 2d8:	83 c2 01             	add    $0x1,%edx
 2db:	83 c1 01             	add    $0x1,%ecx
 2de:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
 2e2:	38 41 ff             	cmp    %al,-0x1(%ecx)
 2e5:	75 11                	jne    2f8 <mystrcmp+0x78>
    while(a--){
 2e7:	39 d3                	cmp    %edx,%ebx
 2e9:	75 ed                	jne    2d8 <mystrcmp+0x58>
}
 2eb:	5b                   	pop    %ebx
    return 1;
 2ec:	b8 01 00 00 00       	mov    $0x1,%eax
}
 2f1:	5e                   	pop    %esi
 2f2:	5d                   	pop    %ebp
 2f3:	c3                   	ret    
 2f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2f8:	5b                   	pop    %ebx
    if(a!=b)return 0;
 2f9:	31 c0                	xor    %eax,%eax
}
 2fb:	5e                   	pop    %esi
 2fc:	5d                   	pop    %ebp
 2fd:	c3                   	ret    
 2fe:	66 90                	xchg   %ax,%ax

00000300 <fmtname>:

char*
fmtname(char *path)
{
 300:	55                   	push   %ebp
 301:	89 e5                	mov    %esp,%ebp
 303:	56                   	push   %esi
 304:	53                   	push   %ebx
 305:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
 308:	83 ec 0c             	sub    $0xc,%esp
 30b:	53                   	push   %ebx
 30c:	e8 9f fd ff ff       	call   b0 <strlen>
 311:	83 c4 10             	add    $0x10,%esp
 314:	01 d8                	add    %ebx,%eax
 316:	73 0f                	jae    327 <fmtname+0x27>
 318:	eb 12                	jmp    32c <fmtname+0x2c>
 31a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 320:	83 e8 01             	sub    $0x1,%eax
 323:	39 c3                	cmp    %eax,%ebx
 325:	77 05                	ja     32c <fmtname+0x2c>
 327:	80 38 2f             	cmpb   $0x2f,(%eax)
 32a:	75 f4                	jne    320 <fmtname+0x20>
    ;
  p++;
 32c:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
 32f:	83 ec 0c             	sub    $0xc,%esp
 332:	53                   	push   %ebx
 333:	e8 78 fd ff ff       	call   b0 <strlen>
 338:	83 c4 10             	add    $0x10,%esp
 33b:	83 f8 0d             	cmp    $0xd,%eax
 33e:	77 4a                	ja     38a <fmtname+0x8a>
    return p;
  memmove(buf, p, strlen(p));
 340:	83 ec 0c             	sub    $0xc,%esp
 343:	53                   	push   %ebx
 344:	e8 67 fd ff ff       	call   b0 <strlen>
 349:	83 c4 0c             	add    $0xc,%esp
 34c:	50                   	push   %eax
 34d:	53                   	push   %ebx
 34e:	68 e0 0e 00 00       	push   $0xee0
 353:	e8 f8 fe ff ff       	call   250 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 358:	89 1c 24             	mov    %ebx,(%esp)
 35b:	e8 50 fd ff ff       	call   b0 <strlen>
 360:	89 1c 24             	mov    %ebx,(%esp)
 363:	89 c6                	mov    %eax,%esi
  return buf;
 365:	bb e0 0e 00 00       	mov    $0xee0,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 36a:	e8 41 fd ff ff       	call   b0 <strlen>
 36f:	ba 0e 00 00 00       	mov    $0xe,%edx
 374:	83 c4 0c             	add    $0xc,%esp
 377:	05 e0 0e 00 00       	add    $0xee0,%eax
 37c:	29 f2                	sub    %esi,%edx
 37e:	52                   	push   %edx
 37f:	6a 20                	push   $0x20
 381:	50                   	push   %eax
 382:	e8 59 fd ff ff       	call   e0 <memset>
  return buf;
 387:	83 c4 10             	add    $0x10,%esp
}
 38a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 38d:	89 d8                	mov    %ebx,%eax
 38f:	5b                   	pop    %ebx
 390:	5e                   	pop    %esi
 391:	5d                   	pop    %ebp
 392:	c3                   	ret    
 393:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 399:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000003a0 <ls>:

void
ls(char *path)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	57                   	push   %edi
 3a4:	56                   	push   %esi
 3a5:	53                   	push   %ebx
 3a6:	81 ec 5c 02 00 00    	sub    $0x25c,%esp

  int cid = getcid();
 3ac:	e8 6d 03 00 00       	call   71e <getcid>

  printf(2, "Cid is: %d\n", cid);
 3b1:	83 ec 04             	sub    $0x4,%esp
  int cid = getcid();
 3b4:	89 c7                	mov    %eax,%edi
  printf(2, "Cid is: %d\n", cid);
 3b6:	50                   	push   %eax
 3b7:	68 28 0b 00 00       	push   $0xb28
 3bc:	6a 02                	push   $0x2
 3be:	e8 0d 04 00 00       	call   7d0 <printf>
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  if((fd = open(path, 0)) < 0){
 3c3:	59                   	pop    %ecx
 3c4:	5b                   	pop    %ebx
 3c5:	6a 00                	push   $0x0
 3c7:	ff 75 08             	pushl  0x8(%ebp)
 3ca:	e8 a7 02 00 00       	call   676 <open>
 3cf:	83 c4 10             	add    $0x10,%esp
 3d2:	85 c0                	test   %eax,%eax
 3d4:	78 5a                	js     430 <ls+0x90>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 3d6:	8d b5 d0 fd ff ff    	lea    -0x230(%ebp),%esi
 3dc:	83 ec 08             	sub    $0x8,%esp
 3df:	89 c3                	mov    %eax,%ebx
 3e1:	56                   	push   %esi
 3e2:	50                   	push   %eax
 3e3:	e8 a6 02 00 00       	call   68e <fstat>
 3e8:	83 c4 10             	add    $0x10,%esp
 3eb:	85 c0                	test   %eax,%eax
 3ed:	0f 88 cd 00 00 00    	js     4c0 <ls+0x120>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  switch(st.type){
 3f3:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 3fa:	66 83 f8 01          	cmp    $0x1,%ax
 3fe:	74 50                	je     450 <ls+0xb0>
 400:	66 83 f8 02          	cmp    $0x2,%ax
 404:	75 12                	jne    418 <ls+0x78>
  case T_FILE:
    if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 406:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 40c:	8d 42 01             	lea    0x1(%edx),%eax
 40f:	83 f8 01             	cmp    $0x1,%eax
 412:	76 6c                	jbe    480 <ls+0xe0>
 414:	39 fa                	cmp    %edi,%edx
 416:	74 68                	je     480 <ls+0xe0>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
    }
    break;
  }
  close(fd);
 418:	83 ec 0c             	sub    $0xc,%esp
 41b:	53                   	push   %ebx
 41c:	e8 3d 02 00 00       	call   65e <close>
 421:	83 c4 10             	add    $0x10,%esp

}
 424:	8d 65 f4             	lea    -0xc(%ebp),%esp
 427:	5b                   	pop    %ebx
 428:	5e                   	pop    %esi
 429:	5f                   	pop    %edi
 42a:	5d                   	pop    %ebp
 42b:	c3                   	ret    
 42c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
 430:	83 ec 04             	sub    $0x4,%esp
 433:	ff 75 08             	pushl  0x8(%ebp)
 436:	68 34 0b 00 00       	push   $0xb34
 43b:	6a 02                	push   $0x2
 43d:	e8 8e 03 00 00       	call   7d0 <printf>
    return;
 442:	83 c4 10             	add    $0x10,%esp
}
 445:	8d 65 f4             	lea    -0xc(%ebp),%esp
 448:	5b                   	pop    %ebx
 449:	5e                   	pop    %esi
 44a:	5f                   	pop    %edi
 44b:	5d                   	pop    %ebp
 44c:	c3                   	ret    
 44d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 450:	83 ec 0c             	sub    $0xc,%esp
 453:	ff 75 08             	pushl  0x8(%ebp)
 456:	e8 55 fc ff ff       	call   b0 <strlen>
 45b:	83 c0 10             	add    $0x10,%eax
 45e:	83 c4 10             	add    $0x10,%esp
 461:	3d 00 02 00 00       	cmp    $0x200,%eax
 466:	0f 86 7c 00 00 00    	jbe    4e8 <ls+0x148>
      printf(1, "ls: path too long\n");
 46c:	83 ec 08             	sub    $0x8,%esp
 46f:	68 6c 0b 00 00       	push   $0xb6c
 474:	6a 01                	push   $0x1
 476:	e8 55 03 00 00       	call   7d0 <printf>
      break;
 47b:	83 c4 10             	add    $0x10,%esp
 47e:	eb 98                	jmp    418 <ls+0x78>
    printf(1, "%s %d %d %d %d\n", fmtname(path), st.type, st.ino, st.size, st.cid);
 480:	83 ec 0c             	sub    $0xc,%esp
 483:	ff 75 08             	pushl  0x8(%ebp)
 486:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 48c:	8b bd e0 fd ff ff    	mov    -0x220(%ebp),%edi
 492:	8b b5 d8 fd ff ff    	mov    -0x228(%ebp),%esi
 498:	e8 63 fe ff ff       	call   300 <fmtname>
 49d:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 4a3:	83 c4 0c             	add    $0xc,%esp
 4a6:	52                   	push   %edx
 4a7:	57                   	push   %edi
 4a8:	56                   	push   %esi
 4a9:	6a 02                	push   $0x2
 4ab:	50                   	push   %eax
 4ac:	68 5c 0b 00 00       	push   $0xb5c
 4b1:	6a 01                	push   $0x1
 4b3:	e8 18 03 00 00       	call   7d0 <printf>
    break;
 4b8:	83 c4 20             	add    $0x20,%esp
 4bb:	e9 58 ff ff ff       	jmp    418 <ls+0x78>
    printf(2, "ls: cannot stat %s\n", path);
 4c0:	83 ec 04             	sub    $0x4,%esp
 4c3:	ff 75 08             	pushl  0x8(%ebp)
 4c6:	68 48 0b 00 00       	push   $0xb48
 4cb:	6a 02                	push   $0x2
 4cd:	e8 fe 02 00 00       	call   7d0 <printf>
    close(fd);
 4d2:	89 1c 24             	mov    %ebx,(%esp)
 4d5:	e8 84 01 00 00       	call   65e <close>
    return;
 4da:	83 c4 10             	add    $0x10,%esp
}
 4dd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 4e0:	5b                   	pop    %ebx
 4e1:	5e                   	pop    %esi
 4e2:	5f                   	pop    %edi
 4e3:	5d                   	pop    %ebp
 4e4:	c3                   	ret    
 4e5:	8d 76 00             	lea    0x0(%esi),%esi
    strcpy(buf, path);
 4e8:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 4ee:	83 ec 08             	sub    $0x8,%esp
 4f1:	ff 75 08             	pushl  0x8(%ebp)
 4f4:	50                   	push   %eax
 4f5:	e8 36 fb ff ff       	call   30 <strcpy>
    p = buf+strlen(buf);
 4fa:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 500:	89 04 24             	mov    %eax,(%esp)
 503:	e8 a8 fb ff ff       	call   b0 <strlen>
 508:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 50e:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 511:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 513:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 516:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 51c:	c6 00 2f             	movb   $0x2f,(%eax)
 51f:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 525:	8d 76 00             	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 528:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
 52e:	83 ec 04             	sub    $0x4,%esp
 531:	6a 10                	push   $0x10
 533:	50                   	push   %eax
 534:	53                   	push   %ebx
 535:	e8 14 01 00 00       	call   64e <read>
 53a:	83 c4 10             	add    $0x10,%esp
 53d:	83 f8 10             	cmp    $0x10,%eax
 540:	0f 85 d2 fe ff ff    	jne    418 <ls+0x78>
      if(de.inum == 0)
 546:	66 83 bd c0 fd ff ff 	cmpw   $0x0,-0x240(%ebp)
 54d:	00 
 54e:	74 d8                	je     528 <ls+0x188>
      memmove(p, de.name, DIRSIZ);
 550:	8d 85 c2 fd ff ff    	lea    -0x23e(%ebp),%eax
 556:	83 ec 04             	sub    $0x4,%esp
 559:	6a 0e                	push   $0xe
 55b:	50                   	push   %eax
 55c:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 562:	e8 e9 fc ff ff       	call   250 <memmove>
      p[DIRSIZ] = 0;
 567:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 56d:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 571:	58                   	pop    %eax
 572:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 578:	5a                   	pop    %edx
 579:	56                   	push   %esi
 57a:	50                   	push   %eax
 57b:	e8 40 fc ff ff       	call   1c0 <stat>
 580:	83 c4 10             	add    $0x10,%esp
 583:	85 c0                	test   %eax,%eax
 585:	0f 88 85 00 00 00    	js     610 <ls+0x270>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 58b:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 591:	8d 42 01             	lea    0x1(%edx),%eax
 594:	83 f8 01             	cmp    $0x1,%eax
 597:	76 04                	jbe    59d <ls+0x1fd>
 599:	39 fa                	cmp    %edi,%edx
 59b:	75 8b                	jne    528 <ls+0x188>
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
 59d:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
 5a3:	89 95 a0 fd ff ff    	mov    %edx,-0x260(%ebp)
 5a9:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 5af:	83 ec 0c             	sub    $0xc,%esp
 5b2:	8b 85 d8 fd ff ff    	mov    -0x228(%ebp),%eax
 5b8:	52                   	push   %edx
 5b9:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 5bf:	0f bf 8d d0 fd ff ff 	movswl -0x230(%ebp),%ecx
 5c6:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 5cc:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 5d2:	e8 29 fd ff ff       	call   300 <fmtname>
 5d7:	8b 95 a0 fd ff ff    	mov    -0x260(%ebp),%edx
 5dd:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
 5e3:	83 c4 0c             	add    $0xc,%esp
 5e6:	52                   	push   %edx
 5e7:	51                   	push   %ecx
 5e8:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 5ee:	ff b5 a8 fd ff ff    	pushl  -0x258(%ebp)
 5f4:	50                   	push   %eax
 5f5:	68 5c 0b 00 00       	push   $0xb5c
 5fa:	6a 01                	push   $0x1
 5fc:	e8 cf 01 00 00       	call   7d0 <printf>
 601:	83 c4 20             	add    $0x20,%esp
 604:	e9 1f ff ff ff       	jmp    528 <ls+0x188>
 609:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 610:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 616:	83 ec 04             	sub    $0x4,%esp
 619:	50                   	push   %eax
 61a:	68 48 0b 00 00       	push   $0xb48
 61f:	6a 01                	push   $0x1
 621:	e8 aa 01 00 00       	call   7d0 <printf>
        continue;
 626:	83 c4 10             	add    $0x10,%esp
 629:	e9 fa fe ff ff       	jmp    528 <ls+0x188>

0000062e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 62e:	b8 01 00 00 00       	mov    $0x1,%eax
 633:	cd 40                	int    $0x40
 635:	c3                   	ret    

00000636 <exit>:
SYSCALL(exit)
 636:	b8 02 00 00 00       	mov    $0x2,%eax
 63b:	cd 40                	int    $0x40
 63d:	c3                   	ret    

0000063e <wait>:
SYSCALL(wait)
 63e:	b8 03 00 00 00       	mov    $0x3,%eax
 643:	cd 40                	int    $0x40
 645:	c3                   	ret    

00000646 <pipe>:
SYSCALL(pipe)
 646:	b8 04 00 00 00       	mov    $0x4,%eax
 64b:	cd 40                	int    $0x40
 64d:	c3                   	ret    

0000064e <read>:
SYSCALL(read)
 64e:	b8 05 00 00 00       	mov    $0x5,%eax
 653:	cd 40                	int    $0x40
 655:	c3                   	ret    

00000656 <write>:
SYSCALL(write)
 656:	b8 10 00 00 00       	mov    $0x10,%eax
 65b:	cd 40                	int    $0x40
 65d:	c3                   	ret    

0000065e <close>:
SYSCALL(close)
 65e:	b8 15 00 00 00       	mov    $0x15,%eax
 663:	cd 40                	int    $0x40
 665:	c3                   	ret    

00000666 <kill>:
SYSCALL(kill)
 666:	b8 06 00 00 00       	mov    $0x6,%eax
 66b:	cd 40                	int    $0x40
 66d:	c3                   	ret    

0000066e <exec>:
SYSCALL(exec)
 66e:	b8 07 00 00 00       	mov    $0x7,%eax
 673:	cd 40                	int    $0x40
 675:	c3                   	ret    

00000676 <open>:
SYSCALL(open)
 676:	b8 0f 00 00 00       	mov    $0xf,%eax
 67b:	cd 40                	int    $0x40
 67d:	c3                   	ret    

0000067e <mknod>:
SYSCALL(mknod)
 67e:	b8 11 00 00 00       	mov    $0x11,%eax
 683:	cd 40                	int    $0x40
 685:	c3                   	ret    

00000686 <unlink>:
SYSCALL(unlink)
 686:	b8 12 00 00 00       	mov    $0x12,%eax
 68b:	cd 40                	int    $0x40
 68d:	c3                   	ret    

0000068e <fstat>:
SYSCALL(fstat)
 68e:	b8 08 00 00 00       	mov    $0x8,%eax
 693:	cd 40                	int    $0x40
 695:	c3                   	ret    

00000696 <link>:
SYSCALL(link)
 696:	b8 13 00 00 00       	mov    $0x13,%eax
 69b:	cd 40                	int    $0x40
 69d:	c3                   	ret    

0000069e <mkdir>:
SYSCALL(mkdir)
 69e:	b8 14 00 00 00       	mov    $0x14,%eax
 6a3:	cd 40                	int    $0x40
 6a5:	c3                   	ret    

000006a6 <chdir>:
SYSCALL(chdir)
 6a6:	b8 09 00 00 00       	mov    $0x9,%eax
 6ab:	cd 40                	int    $0x40
 6ad:	c3                   	ret    

000006ae <dup>:
SYSCALL(dup)
 6ae:	b8 0a 00 00 00       	mov    $0xa,%eax
 6b3:	cd 40                	int    $0x40
 6b5:	c3                   	ret    

000006b6 <getpid>:
SYSCALL(getpid)
 6b6:	b8 0b 00 00 00       	mov    $0xb,%eax
 6bb:	cd 40                	int    $0x40
 6bd:	c3                   	ret    

000006be <sbrk>:
SYSCALL(sbrk)
 6be:	b8 0c 00 00 00       	mov    $0xc,%eax
 6c3:	cd 40                	int    $0x40
 6c5:	c3                   	ret    

000006c6 <sleep>:
SYSCALL(sleep)
 6c6:	b8 0d 00 00 00       	mov    $0xd,%eax
 6cb:	cd 40                	int    $0x40
 6cd:	c3                   	ret    

000006ce <uptime>:
SYSCALL(uptime)
 6ce:	b8 0e 00 00 00       	mov    $0xe,%eax
 6d3:	cd 40                	int    $0x40
 6d5:	c3                   	ret    

000006d6 <halt>:
SYSCALL(halt)
 6d6:	b8 16 00 00 00       	mov    $0x16,%eax
 6db:	cd 40                	int    $0x40
 6dd:	c3                   	ret    

000006de <toggle>:
SYSCALL(toggle)
 6de:	b8 17 00 00 00       	mov    $0x17,%eax
 6e3:	cd 40                	int    $0x40
 6e5:	c3                   	ret    

000006e6 <ps>:
SYSCALL(ps)
 6e6:	b8 18 00 00 00       	mov    $0x18,%eax
 6eb:	cd 40                	int    $0x40
 6ed:	c3                   	ret    

000006ee <create_container>:
SYSCALL(create_container)
 6ee:	b8 1c 00 00 00       	mov    $0x1c,%eax
 6f3:	cd 40                	int    $0x40
 6f5:	c3                   	ret    

000006f6 <destroy_container>:
SYSCALL(destroy_container)
 6f6:	b8 19 00 00 00       	mov    $0x19,%eax
 6fb:	cd 40                	int    $0x40
 6fd:	c3                   	ret    

000006fe <join_container>:
SYSCALL(join_container)
 6fe:	b8 1a 00 00 00       	mov    $0x1a,%eax
 703:	cd 40                	int    $0x40
 705:	c3                   	ret    

00000706 <leave_container>:
SYSCALL(leave_container)
 706:	b8 1b 00 00 00       	mov    $0x1b,%eax
 70b:	cd 40                	int    $0x40
 70d:	c3                   	ret    

0000070e <send>:
SYSCALL(send)
 70e:	b8 1d 00 00 00       	mov    $0x1d,%eax
 713:	cd 40                	int    $0x40
 715:	c3                   	ret    

00000716 <recv>:
SYSCALL(recv)
 716:	b8 1e 00 00 00       	mov    $0x1e,%eax
 71b:	cd 40                	int    $0x40
 71d:	c3                   	ret    

0000071e <getcid>:
SYSCALL(getcid)
 71e:	b8 1f 00 00 00       	mov    $0x1f,%eax
 723:	cd 40                	int    $0x40
 725:	c3                   	ret    
 726:	66 90                	xchg   %ax,%ax
 728:	66 90                	xchg   %ax,%ax
 72a:	66 90                	xchg   %ax,%ax
 72c:	66 90                	xchg   %ax,%ax
 72e:	66 90                	xchg   %ax,%ax

00000730 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 730:	55                   	push   %ebp
 731:	89 e5                	mov    %esp,%ebp
 733:	57                   	push   %edi
 734:	56                   	push   %esi
 735:	53                   	push   %ebx
 736:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 739:	85 d2                	test   %edx,%edx
{
 73b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 73e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 740:	79 76                	jns    7b8 <printint+0x88>
 742:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 746:	74 70                	je     7b8 <printint+0x88>
    x = -xx;
 748:	f7 d8                	neg    %eax
    neg = 1;
 74a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 751:	31 f6                	xor    %esi,%esi
 753:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 756:	eb 0a                	jmp    762 <printint+0x32>
 758:	90                   	nop
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 760:	89 fe                	mov    %edi,%esi
 762:	31 d2                	xor    %edx,%edx
 764:	8d 7e 01             	lea    0x1(%esi),%edi
 767:	f7 f1                	div    %ecx
 769:	0f b6 92 88 0b 00 00 	movzbl 0xb88(%edx),%edx
  }while((x /= base) != 0);
 770:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 772:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 775:	75 e9                	jne    760 <printint+0x30>
  if(neg)
 777:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 77a:	85 c0                	test   %eax,%eax
 77c:	74 08                	je     786 <printint+0x56>
    buf[i++] = '-';
 77e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 783:	8d 7e 02             	lea    0x2(%esi),%edi
 786:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 78a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 78d:	8d 76 00             	lea    0x0(%esi),%esi
 790:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 793:	83 ec 04             	sub    $0x4,%esp
 796:	83 ee 01             	sub    $0x1,%esi
 799:	6a 01                	push   $0x1
 79b:	53                   	push   %ebx
 79c:	57                   	push   %edi
 79d:	88 45 d7             	mov    %al,-0x29(%ebp)
 7a0:	e8 b1 fe ff ff       	call   656 <write>

  while(--i >= 0)
 7a5:	83 c4 10             	add    $0x10,%esp
 7a8:	39 de                	cmp    %ebx,%esi
 7aa:	75 e4                	jne    790 <printint+0x60>
    putc(fd, buf[i]);
}
 7ac:	8d 65 f4             	lea    -0xc(%ebp),%esp
 7af:	5b                   	pop    %ebx
 7b0:	5e                   	pop    %esi
 7b1:	5f                   	pop    %edi
 7b2:	5d                   	pop    %ebp
 7b3:	c3                   	ret    
 7b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 7b8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 7bf:	eb 90                	jmp    751 <printint+0x21>
 7c1:	eb 0d                	jmp    7d0 <printf>
 7c3:	90                   	nop
 7c4:	90                   	nop
 7c5:	90                   	nop
 7c6:	90                   	nop
 7c7:	90                   	nop
 7c8:	90                   	nop
 7c9:	90                   	nop
 7ca:	90                   	nop
 7cb:	90                   	nop
 7cc:	90                   	nop
 7cd:	90                   	nop
 7ce:	90                   	nop
 7cf:	90                   	nop

000007d0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 7d0:	55                   	push   %ebp
 7d1:	89 e5                	mov    %esp,%ebp
 7d3:	57                   	push   %edi
 7d4:	56                   	push   %esi
 7d5:	53                   	push   %ebx
 7d6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 7d9:	8b 75 0c             	mov    0xc(%ebp),%esi
 7dc:	0f b6 1e             	movzbl (%esi),%ebx
 7df:	84 db                	test   %bl,%bl
 7e1:	0f 84 b3 00 00 00    	je     89a <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 7e7:	8d 45 10             	lea    0x10(%ebp),%eax
 7ea:	83 c6 01             	add    $0x1,%esi
  state = 0;
 7ed:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 7ef:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 7f2:	eb 2f                	jmp    823 <printf+0x53>
 7f4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 7f8:	83 f8 25             	cmp    $0x25,%eax
 7fb:	0f 84 a7 00 00 00    	je     8a8 <printf+0xd8>
  write(fd, &c, 1);
 801:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 804:	83 ec 04             	sub    $0x4,%esp
 807:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 80a:	6a 01                	push   $0x1
 80c:	50                   	push   %eax
 80d:	ff 75 08             	pushl  0x8(%ebp)
 810:	e8 41 fe ff ff       	call   656 <write>
 815:	83 c4 10             	add    $0x10,%esp
 818:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 81b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 81f:	84 db                	test   %bl,%bl
 821:	74 77                	je     89a <printf+0xca>
    if(state == 0){
 823:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 825:	0f be cb             	movsbl %bl,%ecx
 828:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 82b:	74 cb                	je     7f8 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 82d:	83 ff 25             	cmp    $0x25,%edi
 830:	75 e6                	jne    818 <printf+0x48>
      if(c == 'd'){
 832:	83 f8 64             	cmp    $0x64,%eax
 835:	0f 84 05 01 00 00    	je     940 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 83b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 841:	83 f9 70             	cmp    $0x70,%ecx
 844:	74 72                	je     8b8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 846:	83 f8 73             	cmp    $0x73,%eax
 849:	0f 84 99 00 00 00    	je     8e8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 84f:	83 f8 63             	cmp    $0x63,%eax
 852:	0f 84 08 01 00 00    	je     960 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 858:	83 f8 25             	cmp    $0x25,%eax
 85b:	0f 84 ef 00 00 00    	je     950 <printf+0x180>
  write(fd, &c, 1);
 861:	8d 45 e7             	lea    -0x19(%ebp),%eax
 864:	83 ec 04             	sub    $0x4,%esp
 867:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 86b:	6a 01                	push   $0x1
 86d:	50                   	push   %eax
 86e:	ff 75 08             	pushl  0x8(%ebp)
 871:	e8 e0 fd ff ff       	call   656 <write>
 876:	83 c4 0c             	add    $0xc,%esp
 879:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 87c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 87f:	6a 01                	push   $0x1
 881:	50                   	push   %eax
 882:	ff 75 08             	pushl  0x8(%ebp)
 885:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 888:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 88a:	e8 c7 fd ff ff       	call   656 <write>
  for(i = 0; fmt[i]; i++){
 88f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 893:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 896:	84 db                	test   %bl,%bl
 898:	75 89                	jne    823 <printf+0x53>
    }
  }
}
 89a:	8d 65 f4             	lea    -0xc(%ebp),%esp
 89d:	5b                   	pop    %ebx
 89e:	5e                   	pop    %esi
 89f:	5f                   	pop    %edi
 8a0:	5d                   	pop    %ebp
 8a1:	c3                   	ret    
 8a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 8a8:	bf 25 00 00 00       	mov    $0x25,%edi
 8ad:	e9 66 ff ff ff       	jmp    818 <printf+0x48>
 8b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 8b8:	83 ec 0c             	sub    $0xc,%esp
 8bb:	b9 10 00 00 00       	mov    $0x10,%ecx
 8c0:	6a 00                	push   $0x0
 8c2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 8c5:	8b 45 08             	mov    0x8(%ebp),%eax
 8c8:	8b 17                	mov    (%edi),%edx
 8ca:	e8 61 fe ff ff       	call   730 <printint>
        ap++;
 8cf:	89 f8                	mov    %edi,%eax
 8d1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 8d4:	31 ff                	xor    %edi,%edi
        ap++;
 8d6:	83 c0 04             	add    $0x4,%eax
 8d9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 8dc:	e9 37 ff ff ff       	jmp    818 <printf+0x48>
 8e1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 8e8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 8eb:	8b 08                	mov    (%eax),%ecx
        ap++;
 8ed:	83 c0 04             	add    $0x4,%eax
 8f0:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 8f3:	85 c9                	test   %ecx,%ecx
 8f5:	0f 84 8e 00 00 00    	je     989 <printf+0x1b9>
        while(*s != 0){
 8fb:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 8fe:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 900:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 902:	84 c0                	test   %al,%al
 904:	0f 84 0e ff ff ff    	je     818 <printf+0x48>
 90a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 90d:	89 de                	mov    %ebx,%esi
 90f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 912:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 915:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 918:	83 ec 04             	sub    $0x4,%esp
          s++;
 91b:	83 c6 01             	add    $0x1,%esi
 91e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 921:	6a 01                	push   $0x1
 923:	57                   	push   %edi
 924:	53                   	push   %ebx
 925:	e8 2c fd ff ff       	call   656 <write>
        while(*s != 0){
 92a:	0f b6 06             	movzbl (%esi),%eax
 92d:	83 c4 10             	add    $0x10,%esp
 930:	84 c0                	test   %al,%al
 932:	75 e4                	jne    918 <printf+0x148>
 934:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 937:	31 ff                	xor    %edi,%edi
 939:	e9 da fe ff ff       	jmp    818 <printf+0x48>
 93e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 940:	83 ec 0c             	sub    $0xc,%esp
 943:	b9 0a 00 00 00       	mov    $0xa,%ecx
 948:	6a 01                	push   $0x1
 94a:	e9 73 ff ff ff       	jmp    8c2 <printf+0xf2>
 94f:	90                   	nop
  write(fd, &c, 1);
 950:	83 ec 04             	sub    $0x4,%esp
 953:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 956:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 959:	6a 01                	push   $0x1
 95b:	e9 21 ff ff ff       	jmp    881 <printf+0xb1>
        putc(fd, *ap);
 960:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 963:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 966:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 968:	6a 01                	push   $0x1
        ap++;
 96a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 96d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 970:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 973:	50                   	push   %eax
 974:	ff 75 08             	pushl  0x8(%ebp)
 977:	e8 da fc ff ff       	call   656 <write>
        ap++;
 97c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 97f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 982:	31 ff                	xor    %edi,%edi
 984:	e9 8f fe ff ff       	jmp    818 <printf+0x48>
          s = "(null)";
 989:	bb 7f 0b 00 00       	mov    $0xb7f,%ebx
        while(*s != 0){
 98e:	b8 28 00 00 00       	mov    $0x28,%eax
 993:	e9 72 ff ff ff       	jmp    90a <printf+0x13a>
 998:	66 90                	xchg   %ax,%ax
 99a:	66 90                	xchg   %ax,%ax
 99c:	66 90                	xchg   %ax,%ax
 99e:	66 90                	xchg   %ax,%ax

000009a0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 9a0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9a1:	a1 f0 0e 00 00       	mov    0xef0,%eax
{
 9a6:	89 e5                	mov    %esp,%ebp
 9a8:	57                   	push   %edi
 9a9:	56                   	push   %esi
 9aa:	53                   	push   %ebx
 9ab:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 9ae:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 9b1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 9b8:	39 c8                	cmp    %ecx,%eax
 9ba:	8b 10                	mov    (%eax),%edx
 9bc:	73 32                	jae    9f0 <free+0x50>
 9be:	39 d1                	cmp    %edx,%ecx
 9c0:	72 04                	jb     9c6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9c2:	39 d0                	cmp    %edx,%eax
 9c4:	72 32                	jb     9f8 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 9c6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 9c9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 9cc:	39 fa                	cmp    %edi,%edx
 9ce:	74 30                	je     a00 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 9d0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 9d3:	8b 50 04             	mov    0x4(%eax),%edx
 9d6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 9d9:	39 f1                	cmp    %esi,%ecx
 9db:	74 3a                	je     a17 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 9dd:	89 08                	mov    %ecx,(%eax)
  freep = p;
 9df:	a3 f0 0e 00 00       	mov    %eax,0xef0
}
 9e4:	5b                   	pop    %ebx
 9e5:	5e                   	pop    %esi
 9e6:	5f                   	pop    %edi
 9e7:	5d                   	pop    %ebp
 9e8:	c3                   	ret    
 9e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 9f0:	39 d0                	cmp    %edx,%eax
 9f2:	72 04                	jb     9f8 <free+0x58>
 9f4:	39 d1                	cmp    %edx,%ecx
 9f6:	72 ce                	jb     9c6 <free+0x26>
{
 9f8:	89 d0                	mov    %edx,%eax
 9fa:	eb bc                	jmp    9b8 <free+0x18>
 9fc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 a00:	03 72 04             	add    0x4(%edx),%esi
 a03:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 a06:	8b 10                	mov    (%eax),%edx
 a08:	8b 12                	mov    (%edx),%edx
 a0a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 a0d:	8b 50 04             	mov    0x4(%eax),%edx
 a10:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 a13:	39 f1                	cmp    %esi,%ecx
 a15:	75 c6                	jne    9dd <free+0x3d>
    p->s.size += bp->s.size;
 a17:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 a1a:	a3 f0 0e 00 00       	mov    %eax,0xef0
    p->s.size += bp->s.size;
 a1f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 a22:	8b 53 f8             	mov    -0x8(%ebx),%edx
 a25:	89 10                	mov    %edx,(%eax)
}
 a27:	5b                   	pop    %ebx
 a28:	5e                   	pop    %esi
 a29:	5f                   	pop    %edi
 a2a:	5d                   	pop    %ebp
 a2b:	c3                   	ret    
 a2c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000a30 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 a30:	55                   	push   %ebp
 a31:	89 e5                	mov    %esp,%ebp
 a33:	57                   	push   %edi
 a34:	56                   	push   %esi
 a35:	53                   	push   %ebx
 a36:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a39:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 a3c:	8b 15 f0 0e 00 00    	mov    0xef0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 a42:	8d 78 07             	lea    0x7(%eax),%edi
 a45:	c1 ef 03             	shr    $0x3,%edi
 a48:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 a4b:	85 d2                	test   %edx,%edx
 a4d:	0f 84 9d 00 00 00    	je     af0 <malloc+0xc0>
 a53:	8b 02                	mov    (%edx),%eax
 a55:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 a58:	39 cf                	cmp    %ecx,%edi
 a5a:	76 6c                	jbe    ac8 <malloc+0x98>
 a5c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 a62:	bb 00 10 00 00       	mov    $0x1000,%ebx
 a67:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 a6a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 a71:	eb 0e                	jmp    a81 <malloc+0x51>
 a73:	90                   	nop
 a74:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 a78:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 a7a:	8b 48 04             	mov    0x4(%eax),%ecx
 a7d:	39 f9                	cmp    %edi,%ecx
 a7f:	73 47                	jae    ac8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 a81:	39 05 f0 0e 00 00    	cmp    %eax,0xef0
 a87:	89 c2                	mov    %eax,%edx
 a89:	75 ed                	jne    a78 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 a8b:	83 ec 0c             	sub    $0xc,%esp
 a8e:	56                   	push   %esi
 a8f:	e8 2a fc ff ff       	call   6be <sbrk>
  if(p == (char*)-1)
 a94:	83 c4 10             	add    $0x10,%esp
 a97:	83 f8 ff             	cmp    $0xffffffff,%eax
 a9a:	74 1c                	je     ab8 <malloc+0x88>
  hp->s.size = nu;
 a9c:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 a9f:	83 ec 0c             	sub    $0xc,%esp
 aa2:	83 c0 08             	add    $0x8,%eax
 aa5:	50                   	push   %eax
 aa6:	e8 f5 fe ff ff       	call   9a0 <free>
  return freep;
 aab:	8b 15 f0 0e 00 00    	mov    0xef0,%edx
      if((p = morecore(nunits)) == 0)
 ab1:	83 c4 10             	add    $0x10,%esp
 ab4:	85 d2                	test   %edx,%edx
 ab6:	75 c0                	jne    a78 <malloc+0x48>
        return 0;
  }
}
 ab8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 abb:	31 c0                	xor    %eax,%eax
}
 abd:	5b                   	pop    %ebx
 abe:	5e                   	pop    %esi
 abf:	5f                   	pop    %edi
 ac0:	5d                   	pop    %ebp
 ac1:	c3                   	ret    
 ac2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 ac8:	39 cf                	cmp    %ecx,%edi
 aca:	74 54                	je     b20 <malloc+0xf0>
        p->s.size -= nunits;
 acc:	29 f9                	sub    %edi,%ecx
 ace:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 ad1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 ad4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 ad7:	89 15 f0 0e 00 00    	mov    %edx,0xef0
}
 add:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 ae0:	83 c0 08             	add    $0x8,%eax
}
 ae3:	5b                   	pop    %ebx
 ae4:	5e                   	pop    %esi
 ae5:	5f                   	pop    %edi
 ae6:	5d                   	pop    %ebp
 ae7:	c3                   	ret    
 ae8:	90                   	nop
 ae9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 af0:	c7 05 f0 0e 00 00 f4 	movl   $0xef4,0xef0
 af7:	0e 00 00 
 afa:	c7 05 f4 0e 00 00 f4 	movl   $0xef4,0xef4
 b01:	0e 00 00 
    base.s.size = 0;
 b04:	b8 f4 0e 00 00       	mov    $0xef4,%eax
 b09:	c7 05 f8 0e 00 00 00 	movl   $0x0,0xef8
 b10:	00 00 00 
 b13:	e9 44 ff ff ff       	jmp    a5c <malloc+0x2c>
 b18:	90                   	nop
 b19:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 b20:	8b 08                	mov    (%eax),%ecx
 b22:	89 0a                	mov    %ecx,(%edx)
 b24:	eb b1                	jmp    ad7 <malloc+0xa7>
