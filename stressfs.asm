
_stressfs:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
#include "fs.h"
#include "fcntl.h"

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
  int fd, i;
  char path[] = "stressfs0";
   7:	b8 30 00 00 00       	mov    $0x30,%eax
{
   c:	ff 71 fc             	pushl  -0x4(%ecx)
   f:	55                   	push   %ebp
  10:	89 e5                	mov    %esp,%ebp
  12:	57                   	push   %edi
  13:	56                   	push   %esi
  14:	53                   	push   %ebx
  15:	51                   	push   %ecx
  char data[512];

  printf(1, "stressfs starting\n");
  memset(data, 'a', sizeof(data));
  16:	8d b5 e8 fd ff ff    	lea    -0x218(%ebp),%esi

  for(i = 0; i < 4; i++)
  1c:	31 db                	xor    %ebx,%ebx
{
  1e:	81 ec 20 02 00 00    	sub    $0x220,%esp
  char path[] = "stressfs0";
  24:	66 89 85 e6 fd ff ff 	mov    %ax,-0x21a(%ebp)
  2b:	c7 85 de fd ff ff 73 	movl   $0x65727473,-0x222(%ebp)
  32:	74 72 65 
  printf(1, "stressfs starting\n");
  35:	68 38 0c 00 00       	push   $0xc38
  3a:	6a 01                	push   $0x1
  char path[] = "stressfs0";
  3c:	c7 85 e2 fd ff ff 73 	movl   $0x73667373,-0x21e(%ebp)
  43:	73 66 73 
  printf(1, "stressfs starting\n");
  46:	e8 95 08 00 00       	call   8e0 <printf>
  memset(data, 'a', sizeof(data));
  4b:	83 c4 0c             	add    $0xc,%esp
  4e:	68 00 02 00 00       	push   $0x200
  53:	6a 61                	push   $0x61
  55:	56                   	push   %esi
  56:	e8 95 01 00 00       	call   1f0 <memset>
  5b:	83 c4 10             	add    $0x10,%esp
    if(fork() > 0)
  5e:	e8 db 06 00 00       	call   73e <fork>
  63:	85 c0                	test   %eax,%eax
  65:	0f 8f bf 00 00 00    	jg     12a <main+0x12a>
  for(i = 0; i < 4; i++)
  6b:	83 c3 01             	add    $0x1,%ebx
  6e:	83 fb 04             	cmp    $0x4,%ebx
  71:	75 eb                	jne    5e <main+0x5e>
  73:	bf 04 00 00 00       	mov    $0x4,%edi
      break;

  printf(1, "write %d\n", i);
  78:	83 ec 04             	sub    $0x4,%esp
  7b:	53                   	push   %ebx
  7c:	68 4b 0c 00 00       	push   $0xc4b

  path[8] += i;
  fd = open(path, O_CREATE | O_RDWR);
  81:	bb 14 00 00 00       	mov    $0x14,%ebx
  printf(1, "write %d\n", i);
  86:	6a 01                	push   $0x1
  88:	e8 53 08 00 00       	call   8e0 <printf>
  path[8] += i;
  8d:	89 f8                	mov    %edi,%eax
  8f:	00 85 e6 fd ff ff    	add    %al,-0x21a(%ebp)
  fd = open(path, O_CREATE | O_RDWR);
  95:	5f                   	pop    %edi
  96:	58                   	pop    %eax
  97:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  9d:	68 02 02 00 00       	push   $0x202
  a2:	50                   	push   %eax
  a3:	e8 de 06 00 00       	call   786 <open>
  a8:	83 c4 10             	add    $0x10,%esp
  ab:	89 c7                	mov    %eax,%edi
  ad:	8d 76 00             	lea    0x0(%esi),%esi
  for(i = 0; i < 20; i++)
//    printf(fd, "%d\n", i);
    write(fd, data, sizeof(data));
  b0:	83 ec 04             	sub    $0x4,%esp
  b3:	68 00 02 00 00       	push   $0x200
  b8:	56                   	push   %esi
  b9:	57                   	push   %edi
  ba:	e8 a7 06 00 00       	call   766 <write>
  for(i = 0; i < 20; i++)
  bf:	83 c4 10             	add    $0x10,%esp
  c2:	83 eb 01             	sub    $0x1,%ebx
  c5:	75 e9                	jne    b0 <main+0xb0>
  close(fd);
  c7:	83 ec 0c             	sub    $0xc,%esp
  ca:	57                   	push   %edi
  cb:	e8 9e 06 00 00       	call   76e <close>

  printf(1, "read\n");
  d0:	58                   	pop    %eax
  d1:	5a                   	pop    %edx
  d2:	68 55 0c 00 00       	push   $0xc55
  d7:	6a 01                	push   $0x1
  d9:	e8 02 08 00 00       	call   8e0 <printf>

  fd = open(path, O_RDONLY);
  de:	59                   	pop    %ecx
  df:	8d 85 de fd ff ff    	lea    -0x222(%ebp),%eax
  e5:	5b                   	pop    %ebx
  e6:	6a 00                	push   $0x0
  e8:	50                   	push   %eax
  e9:	bb 14 00 00 00       	mov    $0x14,%ebx
  ee:	e8 93 06 00 00       	call   786 <open>
  f3:	83 c4 10             	add    $0x10,%esp
  f6:	89 c7                	mov    %eax,%edi
  f8:	90                   	nop
  f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for (i = 0; i < 20; i++)
    read(fd, data, sizeof(data));
 100:	83 ec 04             	sub    $0x4,%esp
 103:	68 00 02 00 00       	push   $0x200
 108:	56                   	push   %esi
 109:	57                   	push   %edi
 10a:	e8 4f 06 00 00       	call   75e <read>
  for (i = 0; i < 20; i++)
 10f:	83 c4 10             	add    $0x10,%esp
 112:	83 eb 01             	sub    $0x1,%ebx
 115:	75 e9                	jne    100 <main+0x100>
  close(fd);
 117:	83 ec 0c             	sub    $0xc,%esp
 11a:	57                   	push   %edi
 11b:	e8 4e 06 00 00       	call   76e <close>

  wait();
 120:	e8 29 06 00 00       	call   74e <wait>

  exit();
 125:	e8 1c 06 00 00       	call   746 <exit>
 12a:	89 df                	mov    %ebx,%edi
 12c:	e9 47 ff ff ff       	jmp    78 <main+0x78>
 131:	66 90                	xchg   %ax,%ax
 133:	66 90                	xchg   %ax,%ax
 135:	66 90                	xchg   %ax,%ax
 137:	66 90                	xchg   %ax,%ax
 139:	66 90                	xchg   %ax,%ax
 13b:	66 90                	xchg   %ax,%ax
 13d:	66 90                	xchg   %ax,%ax
 13f:	90                   	nop

00000140 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 140:	55                   	push   %ebp
 141:	89 e5                	mov    %esp,%ebp
 143:	53                   	push   %ebx
 144:	8b 45 08             	mov    0x8(%ebp),%eax
 147:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 14a:	89 c2                	mov    %eax,%edx
 14c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 150:	83 c1 01             	add    $0x1,%ecx
 153:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 157:	83 c2 01             	add    $0x1,%edx
 15a:	84 db                	test   %bl,%bl
 15c:	88 5a ff             	mov    %bl,-0x1(%edx)
 15f:	75 ef                	jne    150 <strcpy+0x10>
    ;
  return os;
}
 161:	5b                   	pop    %ebx
 162:	5d                   	pop    %ebp
 163:	c3                   	ret    
 164:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 16a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000170 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 170:	55                   	push   %ebp
 171:	89 e5                	mov    %esp,%ebp
 173:	53                   	push   %ebx
 174:	8b 55 08             	mov    0x8(%ebp),%edx
 177:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 17a:	0f b6 02             	movzbl (%edx),%eax
 17d:	0f b6 19             	movzbl (%ecx),%ebx
 180:	84 c0                	test   %al,%al
 182:	75 1c                	jne    1a0 <strcmp+0x30>
 184:	eb 2a                	jmp    1b0 <strcmp+0x40>
 186:	8d 76 00             	lea    0x0(%esi),%esi
 189:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 190:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 193:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 196:	83 c1 01             	add    $0x1,%ecx
 199:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 19c:	84 c0                	test   %al,%al
 19e:	74 10                	je     1b0 <strcmp+0x40>
 1a0:	38 d8                	cmp    %bl,%al
 1a2:	74 ec                	je     190 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1a4:	29 d8                	sub    %ebx,%eax
}
 1a6:	5b                   	pop    %ebx
 1a7:	5d                   	pop    %ebp
 1a8:	c3                   	ret    
 1a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1b0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1b2:	29 d8                	sub    %ebx,%eax
}
 1b4:	5b                   	pop    %ebx
 1b5:	5d                   	pop    %ebp
 1b6:	c3                   	ret    
 1b7:	89 f6                	mov    %esi,%esi
 1b9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000001c0 <strlen>:

uint
strlen(const char *s)
{
 1c0:	55                   	push   %ebp
 1c1:	89 e5                	mov    %esp,%ebp
 1c3:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 1c6:	80 39 00             	cmpb   $0x0,(%ecx)
 1c9:	74 15                	je     1e0 <strlen+0x20>
 1cb:	31 d2                	xor    %edx,%edx
 1cd:	8d 76 00             	lea    0x0(%esi),%esi
 1d0:	83 c2 01             	add    $0x1,%edx
 1d3:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 1d7:	89 d0                	mov    %edx,%eax
 1d9:	75 f5                	jne    1d0 <strlen+0x10>
    ;
  return n;
}
 1db:	5d                   	pop    %ebp
 1dc:	c3                   	ret    
 1dd:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 1e0:	31 c0                	xor    %eax,%eax
}
 1e2:	5d                   	pop    %ebp
 1e3:	c3                   	ret    
 1e4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1ea:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001f0 <memset>:

void*
memset(void *dst, int c, uint n)
{
 1f0:	55                   	push   %ebp
 1f1:	89 e5                	mov    %esp,%ebp
 1f3:	57                   	push   %edi
 1f4:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 1f7:	8b 4d 10             	mov    0x10(%ebp),%ecx
 1fa:	8b 45 0c             	mov    0xc(%ebp),%eax
 1fd:	89 d7                	mov    %edx,%edi
 1ff:	fc                   	cld    
 200:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 202:	89 d0                	mov    %edx,%eax
 204:	5f                   	pop    %edi
 205:	5d                   	pop    %ebp
 206:	c3                   	ret    
 207:	89 f6                	mov    %esi,%esi
 209:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000210 <strchr>:

char*
strchr(const char *s, char c)
{
 210:	55                   	push   %ebp
 211:	89 e5                	mov    %esp,%ebp
 213:	53                   	push   %ebx
 214:	8b 45 08             	mov    0x8(%ebp),%eax
 217:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 21a:	0f b6 10             	movzbl (%eax),%edx
 21d:	84 d2                	test   %dl,%dl
 21f:	74 1d                	je     23e <strchr+0x2e>
    if(*s == c)
 221:	38 d3                	cmp    %dl,%bl
 223:	89 d9                	mov    %ebx,%ecx
 225:	75 0d                	jne    234 <strchr+0x24>
 227:	eb 17                	jmp    240 <strchr+0x30>
 229:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 230:	38 ca                	cmp    %cl,%dl
 232:	74 0c                	je     240 <strchr+0x30>
  for(; *s; s++)
 234:	83 c0 01             	add    $0x1,%eax
 237:	0f b6 10             	movzbl (%eax),%edx
 23a:	84 d2                	test   %dl,%dl
 23c:	75 f2                	jne    230 <strchr+0x20>
      return (char*)s;
  return 0;
 23e:	31 c0                	xor    %eax,%eax
}
 240:	5b                   	pop    %ebx
 241:	5d                   	pop    %ebp
 242:	c3                   	ret    
 243:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <gets>:

char*
gets(char *buf, int max)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	57                   	push   %edi
 254:	56                   	push   %esi
 255:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 256:	31 f6                	xor    %esi,%esi
 258:	89 f3                	mov    %esi,%ebx
{
 25a:	83 ec 1c             	sub    $0x1c,%esp
 25d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 260:	eb 2f                	jmp    291 <gets+0x41>
 262:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 268:	8d 45 e7             	lea    -0x19(%ebp),%eax
 26b:	83 ec 04             	sub    $0x4,%esp
 26e:	6a 01                	push   $0x1
 270:	50                   	push   %eax
 271:	6a 00                	push   $0x0
 273:	e8 e6 04 00 00       	call   75e <read>
    if(cc < 1)
 278:	83 c4 10             	add    $0x10,%esp
 27b:	85 c0                	test   %eax,%eax
 27d:	7e 1c                	jle    29b <gets+0x4b>
      break;
    buf[i++] = c;
 27f:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 283:	83 c7 01             	add    $0x1,%edi
 286:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 289:	3c 0a                	cmp    $0xa,%al
 28b:	74 23                	je     2b0 <gets+0x60>
 28d:	3c 0d                	cmp    $0xd,%al
 28f:	74 1f                	je     2b0 <gets+0x60>
  for(i=0; i+1 < max; ){
 291:	83 c3 01             	add    $0x1,%ebx
 294:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 297:	89 fe                	mov    %edi,%esi
 299:	7c cd                	jl     268 <gets+0x18>
 29b:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 29d:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2a0:	c6 03 00             	movb   $0x0,(%ebx)
}
 2a3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2a6:	5b                   	pop    %ebx
 2a7:	5e                   	pop    %esi
 2a8:	5f                   	pop    %edi
 2a9:	5d                   	pop    %ebp
 2aa:	c3                   	ret    
 2ab:	90                   	nop
 2ac:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2b0:	8b 75 08             	mov    0x8(%ebp),%esi
 2b3:	8b 45 08             	mov    0x8(%ebp),%eax
 2b6:	01 de                	add    %ebx,%esi
 2b8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 2ba:	c6 03 00             	movb   $0x0,(%ebx)
}
 2bd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2c0:	5b                   	pop    %ebx
 2c1:	5e                   	pop    %esi
 2c2:	5f                   	pop    %edi
 2c3:	5d                   	pop    %ebp
 2c4:	c3                   	ret    
 2c5:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000002d0 <stat>:

int
stat(const char *n, struct stat *st)
{
 2d0:	55                   	push   %ebp
 2d1:	89 e5                	mov    %esp,%ebp
 2d3:	56                   	push   %esi
 2d4:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 2d5:	83 ec 08             	sub    $0x8,%esp
 2d8:	6a 00                	push   $0x0
 2da:	ff 75 08             	pushl  0x8(%ebp)
 2dd:	e8 a4 04 00 00       	call   786 <open>
  if(fd < 0)
 2e2:	83 c4 10             	add    $0x10,%esp
 2e5:	85 c0                	test   %eax,%eax
 2e7:	78 27                	js     310 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 2e9:	83 ec 08             	sub    $0x8,%esp
 2ec:	ff 75 0c             	pushl  0xc(%ebp)
 2ef:	89 c3                	mov    %eax,%ebx
 2f1:	50                   	push   %eax
 2f2:	e8 a7 04 00 00       	call   79e <fstat>
  close(fd);
 2f7:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 2fa:	89 c6                	mov    %eax,%esi
  close(fd);
 2fc:	e8 6d 04 00 00       	call   76e <close>
  return r;
 301:	83 c4 10             	add    $0x10,%esp
}
 304:	8d 65 f8             	lea    -0x8(%ebp),%esp
 307:	89 f0                	mov    %esi,%eax
 309:	5b                   	pop    %ebx
 30a:	5e                   	pop    %esi
 30b:	5d                   	pop    %ebp
 30c:	c3                   	ret    
 30d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 310:	be ff ff ff ff       	mov    $0xffffffff,%esi
 315:	eb ed                	jmp    304 <stat+0x34>
 317:	89 f6                	mov    %esi,%esi
 319:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000320 <atoi>:

int
atoi(const char *s)
{
 320:	55                   	push   %ebp
 321:	89 e5                	mov    %esp,%ebp
 323:	53                   	push   %ebx
 324:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 327:	0f be 11             	movsbl (%ecx),%edx
 32a:	8d 42 d0             	lea    -0x30(%edx),%eax
 32d:	3c 09                	cmp    $0x9,%al
  n = 0;
 32f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 334:	77 1f                	ja     355 <atoi+0x35>
 336:	8d 76 00             	lea    0x0(%esi),%esi
 339:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 340:	8d 04 80             	lea    (%eax,%eax,4),%eax
 343:	83 c1 01             	add    $0x1,%ecx
 346:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 34a:	0f be 11             	movsbl (%ecx),%edx
 34d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 350:	80 fb 09             	cmp    $0x9,%bl
 353:	76 eb                	jbe    340 <atoi+0x20>
  return n;
}
 355:	5b                   	pop    %ebx
 356:	5d                   	pop    %ebp
 357:	c3                   	ret    
 358:	90                   	nop
 359:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

00000360 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	56                   	push   %esi
 364:	53                   	push   %ebx
 365:	8b 5d 10             	mov    0x10(%ebp),%ebx
 368:	8b 45 08             	mov    0x8(%ebp),%eax
 36b:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 36e:	85 db                	test   %ebx,%ebx
 370:	7e 14                	jle    386 <memmove+0x26>
 372:	31 d2                	xor    %edx,%edx
 374:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 378:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 37c:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 37f:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 382:	39 d3                	cmp    %edx,%ebx
 384:	75 f2                	jne    378 <memmove+0x18>
  return vdst;
}
 386:	5b                   	pop    %ebx
 387:	5e                   	pop    %esi
 388:	5d                   	pop    %ebp
 389:	c3                   	ret    
 38a:	66 90                	xchg   %ax,%ax
 38c:	66 90                	xchg   %ax,%ax
 38e:	66 90                	xchg   %ax,%ax

00000390 <mystrcmp>:
#include "ls.h"
// #include "defs.h"

int
mystrcmp (char *s1, char *s2)
{
 390:	55                   	push   %ebp
 391:	89 e5                	mov    %esp,%ebp
 393:	56                   	push   %esi
 394:	53                   	push   %ebx
 395:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int a =0,b=0;
 398:	31 db                	xor    %ebx,%ebx
{
 39a:	8b 55 0c             	mov    0xc(%ebp),%edx
    while(*s1){a++;s1++;}
 39d:	80 39 00             	cmpb   $0x0,(%ecx)
 3a0:	0f b6 02             	movzbl (%edx),%eax
 3a3:	74 33                	je     3d8 <mystrcmp+0x48>
 3a5:	8d 76 00             	lea    0x0(%esi),%esi
 3a8:	83 c1 01             	add    $0x1,%ecx
 3ab:	83 c3 01             	add    $0x1,%ebx
 3ae:	80 39 00             	cmpb   $0x0,(%ecx)
 3b1:	75 f5                	jne    3a8 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
 3b3:	84 c0                	test   %al,%al
 3b5:	74 51                	je     408 <mystrcmp+0x78>
    int a =0,b=0;
 3b7:	31 f6                	xor    %esi,%esi
 3b9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
 3c0:	83 c2 01             	add    $0x1,%edx
 3c3:	83 c6 01             	add    $0x1,%esi
 3c6:	80 3a 00             	cmpb   $0x0,(%edx)
 3c9:	75 f5                	jne    3c0 <mystrcmp+0x30>

    if(a!=b)return 0;
 3cb:	31 c0                	xor    %eax,%eax
 3cd:	39 de                	cmp    %ebx,%esi
 3cf:	74 0f                	je     3e0 <mystrcmp+0x50>
    // printf("here");
    while(a--){
        if(*s1++ != *s2++)return 0;
    }
    return 1;
}
 3d1:	5b                   	pop    %ebx
 3d2:	5e                   	pop    %esi
 3d3:	5d                   	pop    %ebp
 3d4:	c3                   	ret    
 3d5:	8d 76 00             	lea    0x0(%esi),%esi
    while(*s2){b++;s2++;}
 3d8:	84 c0                	test   %al,%al
 3da:	75 db                	jne    3b7 <mystrcmp+0x27>
 3dc:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 3e0:	01 d3                	add    %edx,%ebx
 3e2:	eb 13                	jmp    3f7 <mystrcmp+0x67>
 3e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(*s1++ != *s2++)return 0;
 3e8:	83 c2 01             	add    $0x1,%edx
 3eb:	83 c1 01             	add    $0x1,%ecx
 3ee:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
 3f2:	38 41 ff             	cmp    %al,-0x1(%ecx)
 3f5:	75 11                	jne    408 <mystrcmp+0x78>
    while(a--){
 3f7:	39 d3                	cmp    %edx,%ebx
 3f9:	75 ed                	jne    3e8 <mystrcmp+0x58>
}
 3fb:	5b                   	pop    %ebx
    return 1;
 3fc:	b8 01 00 00 00       	mov    $0x1,%eax
}
 401:	5e                   	pop    %esi
 402:	5d                   	pop    %ebp
 403:	c3                   	ret    
 404:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 408:	5b                   	pop    %ebx
    if(a!=b)return 0;
 409:	31 c0                	xor    %eax,%eax
}
 40b:	5e                   	pop    %esi
 40c:	5d                   	pop    %ebp
 40d:	c3                   	ret    
 40e:	66 90                	xchg   %ax,%ax

00000410 <fmtname>:

char*
fmtname(char *path)
{
 410:	55                   	push   %ebp
 411:	89 e5                	mov    %esp,%ebp
 413:	56                   	push   %esi
 414:	53                   	push   %ebx
 415:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
 418:	83 ec 0c             	sub    $0xc,%esp
 41b:	53                   	push   %ebx
 41c:	e8 9f fd ff ff       	call   1c0 <strlen>
 421:	83 c4 10             	add    $0x10,%esp
 424:	01 d8                	add    %ebx,%eax
 426:	73 0f                	jae    437 <fmtname+0x27>
 428:	eb 12                	jmp    43c <fmtname+0x2c>
 42a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 430:	83 e8 01             	sub    $0x1,%eax
 433:	39 c3                	cmp    %eax,%ebx
 435:	77 05                	ja     43c <fmtname+0x2c>
 437:	80 38 2f             	cmpb   $0x2f,(%eax)
 43a:	75 f4                	jne    430 <fmtname+0x20>
    ;
  p++;
 43c:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
 43f:	83 ec 0c             	sub    $0xc,%esp
 442:	53                   	push   %ebx
 443:	e8 78 fd ff ff       	call   1c0 <strlen>
 448:	83 c4 10             	add    $0x10,%esp
 44b:	83 f8 0d             	cmp    $0xd,%eax
 44e:	77 4a                	ja     49a <fmtname+0x8a>
    return p;
  memmove(buf, p, strlen(p));
 450:	83 ec 0c             	sub    $0xc,%esp
 453:	53                   	push   %ebx
 454:	e8 67 fd ff ff       	call   1c0 <strlen>
 459:	83 c4 0c             	add    $0xc,%esp
 45c:	50                   	push   %eax
 45d:	53                   	push   %ebx
 45e:	68 20 10 00 00       	push   $0x1020
 463:	e8 f8 fe ff ff       	call   360 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 468:	89 1c 24             	mov    %ebx,(%esp)
 46b:	e8 50 fd ff ff       	call   1c0 <strlen>
 470:	89 1c 24             	mov    %ebx,(%esp)
 473:	89 c6                	mov    %eax,%esi
  return buf;
 475:	bb 20 10 00 00       	mov    $0x1020,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 47a:	e8 41 fd ff ff       	call   1c0 <strlen>
 47f:	ba 0e 00 00 00       	mov    $0xe,%edx
 484:	83 c4 0c             	add    $0xc,%esp
 487:	05 20 10 00 00       	add    $0x1020,%eax
 48c:	29 f2                	sub    %esi,%edx
 48e:	52                   	push   %edx
 48f:	6a 20                	push   $0x20
 491:	50                   	push   %eax
 492:	e8 59 fd ff ff       	call   1f0 <memset>
  return buf;
 497:	83 c4 10             	add    $0x10,%esp
}
 49a:	8d 65 f8             	lea    -0x8(%ebp),%esp
 49d:	89 d8                	mov    %ebx,%eax
 49f:	5b                   	pop    %ebx
 4a0:	5e                   	pop    %esi
 4a1:	5d                   	pop    %ebp
 4a2:	c3                   	ret    
 4a3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4a9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004b0 <ls>:

void
ls(char *path)
{
 4b0:	55                   	push   %ebp
 4b1:	89 e5                	mov    %esp,%ebp
 4b3:	57                   	push   %edi
 4b4:	56                   	push   %esi
 4b5:	53                   	push   %ebx
 4b6:	81 ec 5c 02 00 00    	sub    $0x25c,%esp

  int cid = getcid();
 4bc:	e8 6d 03 00 00       	call   82e <getcid>

  printf(2, "Cid is: %d\n", cid);
 4c1:	83 ec 04             	sub    $0x4,%esp
  int cid = getcid();
 4c4:	89 c7                	mov    %eax,%edi
  printf(2, "Cid is: %d\n", cid);
 4c6:	50                   	push   %eax
 4c7:	68 5b 0c 00 00       	push   $0xc5b
 4cc:	6a 02                	push   $0x2
 4ce:	e8 0d 04 00 00       	call   8e0 <printf>
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  if((fd = open(path, 0)) < 0){
 4d3:	59                   	pop    %ecx
 4d4:	5b                   	pop    %ebx
 4d5:	6a 00                	push   $0x0
 4d7:	ff 75 08             	pushl  0x8(%ebp)
 4da:	e8 a7 02 00 00       	call   786 <open>
 4df:	83 c4 10             	add    $0x10,%esp
 4e2:	85 c0                	test   %eax,%eax
 4e4:	78 5a                	js     540 <ls+0x90>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 4e6:	8d b5 d0 fd ff ff    	lea    -0x230(%ebp),%esi
 4ec:	83 ec 08             	sub    $0x8,%esp
 4ef:	89 c3                	mov    %eax,%ebx
 4f1:	56                   	push   %esi
 4f2:	50                   	push   %eax
 4f3:	e8 a6 02 00 00       	call   79e <fstat>
 4f8:	83 c4 10             	add    $0x10,%esp
 4fb:	85 c0                	test   %eax,%eax
 4fd:	0f 88 cd 00 00 00    	js     5d0 <ls+0x120>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  switch(st.type){
 503:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 50a:	66 83 f8 01          	cmp    $0x1,%ax
 50e:	74 50                	je     560 <ls+0xb0>
 510:	66 83 f8 02          	cmp    $0x2,%ax
 514:	75 12                	jne    528 <ls+0x78>
  case T_FILE:
    if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 516:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 51c:	8d 42 01             	lea    0x1(%edx),%eax
 51f:	83 f8 01             	cmp    $0x1,%eax
 522:	76 6c                	jbe    590 <ls+0xe0>
 524:	39 fa                	cmp    %edi,%edx
 526:	74 68                	je     590 <ls+0xe0>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
    }
    break;
  }
  close(fd);
 528:	83 ec 0c             	sub    $0xc,%esp
 52b:	53                   	push   %ebx
 52c:	e8 3d 02 00 00       	call   76e <close>
 531:	83 c4 10             	add    $0x10,%esp

}
 534:	8d 65 f4             	lea    -0xc(%ebp),%esp
 537:	5b                   	pop    %ebx
 538:	5e                   	pop    %esi
 539:	5f                   	pop    %edi
 53a:	5d                   	pop    %ebp
 53b:	c3                   	ret    
 53c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
 540:	83 ec 04             	sub    $0x4,%esp
 543:	ff 75 08             	pushl  0x8(%ebp)
 546:	68 67 0c 00 00       	push   $0xc67
 54b:	6a 02                	push   $0x2
 54d:	e8 8e 03 00 00       	call   8e0 <printf>
    return;
 552:	83 c4 10             	add    $0x10,%esp
}
 555:	8d 65 f4             	lea    -0xc(%ebp),%esp
 558:	5b                   	pop    %ebx
 559:	5e                   	pop    %esi
 55a:	5f                   	pop    %edi
 55b:	5d                   	pop    %ebp
 55c:	c3                   	ret    
 55d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 560:	83 ec 0c             	sub    $0xc,%esp
 563:	ff 75 08             	pushl  0x8(%ebp)
 566:	e8 55 fc ff ff       	call   1c0 <strlen>
 56b:	83 c0 10             	add    $0x10,%eax
 56e:	83 c4 10             	add    $0x10,%esp
 571:	3d 00 02 00 00       	cmp    $0x200,%eax
 576:	0f 86 7c 00 00 00    	jbe    5f8 <ls+0x148>
      printf(1, "ls: path too long\n");
 57c:	83 ec 08             	sub    $0x8,%esp
 57f:	68 9f 0c 00 00       	push   $0xc9f
 584:	6a 01                	push   $0x1
 586:	e8 55 03 00 00       	call   8e0 <printf>
      break;
 58b:	83 c4 10             	add    $0x10,%esp
 58e:	eb 98                	jmp    528 <ls+0x78>
    printf(1, "%s %d %d %d %d\n", fmtname(path), st.type, st.ino, st.size, st.cid);
 590:	83 ec 0c             	sub    $0xc,%esp
 593:	ff 75 08             	pushl  0x8(%ebp)
 596:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 59c:	8b bd e0 fd ff ff    	mov    -0x220(%ebp),%edi
 5a2:	8b b5 d8 fd ff ff    	mov    -0x228(%ebp),%esi
 5a8:	e8 63 fe ff ff       	call   410 <fmtname>
 5ad:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 5b3:	83 c4 0c             	add    $0xc,%esp
 5b6:	52                   	push   %edx
 5b7:	57                   	push   %edi
 5b8:	56                   	push   %esi
 5b9:	6a 02                	push   $0x2
 5bb:	50                   	push   %eax
 5bc:	68 8f 0c 00 00       	push   $0xc8f
 5c1:	6a 01                	push   $0x1
 5c3:	e8 18 03 00 00       	call   8e0 <printf>
    break;
 5c8:	83 c4 20             	add    $0x20,%esp
 5cb:	e9 58 ff ff ff       	jmp    528 <ls+0x78>
    printf(2, "ls: cannot stat %s\n", path);
 5d0:	83 ec 04             	sub    $0x4,%esp
 5d3:	ff 75 08             	pushl  0x8(%ebp)
 5d6:	68 7b 0c 00 00       	push   $0xc7b
 5db:	6a 02                	push   $0x2
 5dd:	e8 fe 02 00 00       	call   8e0 <printf>
    close(fd);
 5e2:	89 1c 24             	mov    %ebx,(%esp)
 5e5:	e8 84 01 00 00       	call   76e <close>
    return;
 5ea:	83 c4 10             	add    $0x10,%esp
}
 5ed:	8d 65 f4             	lea    -0xc(%ebp),%esp
 5f0:	5b                   	pop    %ebx
 5f1:	5e                   	pop    %esi
 5f2:	5f                   	pop    %edi
 5f3:	5d                   	pop    %ebp
 5f4:	c3                   	ret    
 5f5:	8d 76 00             	lea    0x0(%esi),%esi
    strcpy(buf, path);
 5f8:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 5fe:	83 ec 08             	sub    $0x8,%esp
 601:	ff 75 08             	pushl  0x8(%ebp)
 604:	50                   	push   %eax
 605:	e8 36 fb ff ff       	call   140 <strcpy>
    p = buf+strlen(buf);
 60a:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 610:	89 04 24             	mov    %eax,(%esp)
 613:	e8 a8 fb ff ff       	call   1c0 <strlen>
 618:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 61e:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 621:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 623:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 626:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 62c:	c6 00 2f             	movb   $0x2f,(%eax)
 62f:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 635:	8d 76 00             	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 638:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
 63e:	83 ec 04             	sub    $0x4,%esp
 641:	6a 10                	push   $0x10
 643:	50                   	push   %eax
 644:	53                   	push   %ebx
 645:	e8 14 01 00 00       	call   75e <read>
 64a:	83 c4 10             	add    $0x10,%esp
 64d:	83 f8 10             	cmp    $0x10,%eax
 650:	0f 85 d2 fe ff ff    	jne    528 <ls+0x78>
      if(de.inum == 0)
 656:	66 83 bd c0 fd ff ff 	cmpw   $0x0,-0x240(%ebp)
 65d:	00 
 65e:	74 d8                	je     638 <ls+0x188>
      memmove(p, de.name, DIRSIZ);
 660:	8d 85 c2 fd ff ff    	lea    -0x23e(%ebp),%eax
 666:	83 ec 04             	sub    $0x4,%esp
 669:	6a 0e                	push   $0xe
 66b:	50                   	push   %eax
 66c:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 672:	e8 e9 fc ff ff       	call   360 <memmove>
      p[DIRSIZ] = 0;
 677:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 67d:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 681:	58                   	pop    %eax
 682:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 688:	5a                   	pop    %edx
 689:	56                   	push   %esi
 68a:	50                   	push   %eax
 68b:	e8 40 fc ff ff       	call   2d0 <stat>
 690:	83 c4 10             	add    $0x10,%esp
 693:	85 c0                	test   %eax,%eax
 695:	0f 88 85 00 00 00    	js     720 <ls+0x270>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 69b:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 6a1:	8d 42 01             	lea    0x1(%edx),%eax
 6a4:	83 f8 01             	cmp    $0x1,%eax
 6a7:	76 04                	jbe    6ad <ls+0x1fd>
 6a9:	39 fa                	cmp    %edi,%edx
 6ab:	75 8b                	jne    638 <ls+0x188>
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
 6ad:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
 6b3:	89 95 a0 fd ff ff    	mov    %edx,-0x260(%ebp)
 6b9:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 6bf:	83 ec 0c             	sub    $0xc,%esp
 6c2:	8b 85 d8 fd ff ff    	mov    -0x228(%ebp),%eax
 6c8:	52                   	push   %edx
 6c9:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 6cf:	0f bf 8d d0 fd ff ff 	movswl -0x230(%ebp),%ecx
 6d6:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 6dc:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 6e2:	e8 29 fd ff ff       	call   410 <fmtname>
 6e7:	8b 95 a0 fd ff ff    	mov    -0x260(%ebp),%edx
 6ed:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
 6f3:	83 c4 0c             	add    $0xc,%esp
 6f6:	52                   	push   %edx
 6f7:	51                   	push   %ecx
 6f8:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 6fe:	ff b5 a8 fd ff ff    	pushl  -0x258(%ebp)
 704:	50                   	push   %eax
 705:	68 8f 0c 00 00       	push   $0xc8f
 70a:	6a 01                	push   $0x1
 70c:	e8 cf 01 00 00       	call   8e0 <printf>
 711:	83 c4 20             	add    $0x20,%esp
 714:	e9 1f ff ff ff       	jmp    638 <ls+0x188>
 719:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 720:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 726:	83 ec 04             	sub    $0x4,%esp
 729:	50                   	push   %eax
 72a:	68 7b 0c 00 00       	push   $0xc7b
 72f:	6a 01                	push   $0x1
 731:	e8 aa 01 00 00       	call   8e0 <printf>
        continue;
 736:	83 c4 10             	add    $0x10,%esp
 739:	e9 fa fe ff ff       	jmp    638 <ls+0x188>

0000073e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 73e:	b8 01 00 00 00       	mov    $0x1,%eax
 743:	cd 40                	int    $0x40
 745:	c3                   	ret    

00000746 <exit>:
SYSCALL(exit)
 746:	b8 02 00 00 00       	mov    $0x2,%eax
 74b:	cd 40                	int    $0x40
 74d:	c3                   	ret    

0000074e <wait>:
SYSCALL(wait)
 74e:	b8 03 00 00 00       	mov    $0x3,%eax
 753:	cd 40                	int    $0x40
 755:	c3                   	ret    

00000756 <pipe>:
SYSCALL(pipe)
 756:	b8 04 00 00 00       	mov    $0x4,%eax
 75b:	cd 40                	int    $0x40
 75d:	c3                   	ret    

0000075e <read>:
SYSCALL(read)
 75e:	b8 05 00 00 00       	mov    $0x5,%eax
 763:	cd 40                	int    $0x40
 765:	c3                   	ret    

00000766 <write>:
SYSCALL(write)
 766:	b8 10 00 00 00       	mov    $0x10,%eax
 76b:	cd 40                	int    $0x40
 76d:	c3                   	ret    

0000076e <close>:
SYSCALL(close)
 76e:	b8 15 00 00 00       	mov    $0x15,%eax
 773:	cd 40                	int    $0x40
 775:	c3                   	ret    

00000776 <kill>:
SYSCALL(kill)
 776:	b8 06 00 00 00       	mov    $0x6,%eax
 77b:	cd 40                	int    $0x40
 77d:	c3                   	ret    

0000077e <exec>:
SYSCALL(exec)
 77e:	b8 07 00 00 00       	mov    $0x7,%eax
 783:	cd 40                	int    $0x40
 785:	c3                   	ret    

00000786 <open>:
SYSCALL(open)
 786:	b8 0f 00 00 00       	mov    $0xf,%eax
 78b:	cd 40                	int    $0x40
 78d:	c3                   	ret    

0000078e <mknod>:
SYSCALL(mknod)
 78e:	b8 11 00 00 00       	mov    $0x11,%eax
 793:	cd 40                	int    $0x40
 795:	c3                   	ret    

00000796 <unlink>:
SYSCALL(unlink)
 796:	b8 12 00 00 00       	mov    $0x12,%eax
 79b:	cd 40                	int    $0x40
 79d:	c3                   	ret    

0000079e <fstat>:
SYSCALL(fstat)
 79e:	b8 08 00 00 00       	mov    $0x8,%eax
 7a3:	cd 40                	int    $0x40
 7a5:	c3                   	ret    

000007a6 <link>:
SYSCALL(link)
 7a6:	b8 13 00 00 00       	mov    $0x13,%eax
 7ab:	cd 40                	int    $0x40
 7ad:	c3                   	ret    

000007ae <mkdir>:
SYSCALL(mkdir)
 7ae:	b8 14 00 00 00       	mov    $0x14,%eax
 7b3:	cd 40                	int    $0x40
 7b5:	c3                   	ret    

000007b6 <chdir>:
SYSCALL(chdir)
 7b6:	b8 09 00 00 00       	mov    $0x9,%eax
 7bb:	cd 40                	int    $0x40
 7bd:	c3                   	ret    

000007be <dup>:
SYSCALL(dup)
 7be:	b8 0a 00 00 00       	mov    $0xa,%eax
 7c3:	cd 40                	int    $0x40
 7c5:	c3                   	ret    

000007c6 <getpid>:
SYSCALL(getpid)
 7c6:	b8 0b 00 00 00       	mov    $0xb,%eax
 7cb:	cd 40                	int    $0x40
 7cd:	c3                   	ret    

000007ce <sbrk>:
SYSCALL(sbrk)
 7ce:	b8 0c 00 00 00       	mov    $0xc,%eax
 7d3:	cd 40                	int    $0x40
 7d5:	c3                   	ret    

000007d6 <sleep>:
SYSCALL(sleep)
 7d6:	b8 0d 00 00 00       	mov    $0xd,%eax
 7db:	cd 40                	int    $0x40
 7dd:	c3                   	ret    

000007de <uptime>:
SYSCALL(uptime)
 7de:	b8 0e 00 00 00       	mov    $0xe,%eax
 7e3:	cd 40                	int    $0x40
 7e5:	c3                   	ret    

000007e6 <halt>:
SYSCALL(halt)
 7e6:	b8 16 00 00 00       	mov    $0x16,%eax
 7eb:	cd 40                	int    $0x40
 7ed:	c3                   	ret    

000007ee <toggle>:
SYSCALL(toggle)
 7ee:	b8 17 00 00 00       	mov    $0x17,%eax
 7f3:	cd 40                	int    $0x40
 7f5:	c3                   	ret    

000007f6 <ps>:
SYSCALL(ps)
 7f6:	b8 18 00 00 00       	mov    $0x18,%eax
 7fb:	cd 40                	int    $0x40
 7fd:	c3                   	ret    

000007fe <create_container>:
SYSCALL(create_container)
 7fe:	b8 1c 00 00 00       	mov    $0x1c,%eax
 803:	cd 40                	int    $0x40
 805:	c3                   	ret    

00000806 <destroy_container>:
SYSCALL(destroy_container)
 806:	b8 19 00 00 00       	mov    $0x19,%eax
 80b:	cd 40                	int    $0x40
 80d:	c3                   	ret    

0000080e <join_container>:
SYSCALL(join_container)
 80e:	b8 1a 00 00 00       	mov    $0x1a,%eax
 813:	cd 40                	int    $0x40
 815:	c3                   	ret    

00000816 <leave_container>:
SYSCALL(leave_container)
 816:	b8 1b 00 00 00       	mov    $0x1b,%eax
 81b:	cd 40                	int    $0x40
 81d:	c3                   	ret    

0000081e <send>:
SYSCALL(send)
 81e:	b8 1d 00 00 00       	mov    $0x1d,%eax
 823:	cd 40                	int    $0x40
 825:	c3                   	ret    

00000826 <recv>:
SYSCALL(recv)
 826:	b8 1e 00 00 00       	mov    $0x1e,%eax
 82b:	cd 40                	int    $0x40
 82d:	c3                   	ret    

0000082e <getcid>:
SYSCALL(getcid)
 82e:	b8 1f 00 00 00       	mov    $0x1f,%eax
 833:	cd 40                	int    $0x40
 835:	c3                   	ret    
 836:	66 90                	xchg   %ax,%ax
 838:	66 90                	xchg   %ax,%ax
 83a:	66 90                	xchg   %ax,%ax
 83c:	66 90                	xchg   %ax,%ax
 83e:	66 90                	xchg   %ax,%ax

00000840 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 840:	55                   	push   %ebp
 841:	89 e5                	mov    %esp,%ebp
 843:	57                   	push   %edi
 844:	56                   	push   %esi
 845:	53                   	push   %ebx
 846:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 849:	85 d2                	test   %edx,%edx
{
 84b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 84e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 850:	79 76                	jns    8c8 <printint+0x88>
 852:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 856:	74 70                	je     8c8 <printint+0x88>
    x = -xx;
 858:	f7 d8                	neg    %eax
    neg = 1;
 85a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 861:	31 f6                	xor    %esi,%esi
 863:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 866:	eb 0a                	jmp    872 <printint+0x32>
 868:	90                   	nop
 869:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 870:	89 fe                	mov    %edi,%esi
 872:	31 d2                	xor    %edx,%edx
 874:	8d 7e 01             	lea    0x1(%esi),%edi
 877:	f7 f1                	div    %ecx
 879:	0f b6 92 bc 0c 00 00 	movzbl 0xcbc(%edx),%edx
  }while((x /= base) != 0);
 880:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 882:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 885:	75 e9                	jne    870 <printint+0x30>
  if(neg)
 887:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 88a:	85 c0                	test   %eax,%eax
 88c:	74 08                	je     896 <printint+0x56>
    buf[i++] = '-';
 88e:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 893:	8d 7e 02             	lea    0x2(%esi),%edi
 896:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 89a:	8b 7d c0             	mov    -0x40(%ebp),%edi
 89d:	8d 76 00             	lea    0x0(%esi),%esi
 8a0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 8a3:	83 ec 04             	sub    $0x4,%esp
 8a6:	83 ee 01             	sub    $0x1,%esi
 8a9:	6a 01                	push   $0x1
 8ab:	53                   	push   %ebx
 8ac:	57                   	push   %edi
 8ad:	88 45 d7             	mov    %al,-0x29(%ebp)
 8b0:	e8 b1 fe ff ff       	call   766 <write>

  while(--i >= 0)
 8b5:	83 c4 10             	add    $0x10,%esp
 8b8:	39 de                	cmp    %ebx,%esi
 8ba:	75 e4                	jne    8a0 <printint+0x60>
    putc(fd, buf[i]);
}
 8bc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8bf:	5b                   	pop    %ebx
 8c0:	5e                   	pop    %esi
 8c1:	5f                   	pop    %edi
 8c2:	5d                   	pop    %ebp
 8c3:	c3                   	ret    
 8c4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 8c8:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 8cf:	eb 90                	jmp    861 <printint+0x21>
 8d1:	eb 0d                	jmp    8e0 <printf>
 8d3:	90                   	nop
 8d4:	90                   	nop
 8d5:	90                   	nop
 8d6:	90                   	nop
 8d7:	90                   	nop
 8d8:	90                   	nop
 8d9:	90                   	nop
 8da:	90                   	nop
 8db:	90                   	nop
 8dc:	90                   	nop
 8dd:	90                   	nop
 8de:	90                   	nop
 8df:	90                   	nop

000008e0 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 8e0:	55                   	push   %ebp
 8e1:	89 e5                	mov    %esp,%ebp
 8e3:	57                   	push   %edi
 8e4:	56                   	push   %esi
 8e5:	53                   	push   %ebx
 8e6:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 8e9:	8b 75 0c             	mov    0xc(%ebp),%esi
 8ec:	0f b6 1e             	movzbl (%esi),%ebx
 8ef:	84 db                	test   %bl,%bl
 8f1:	0f 84 b3 00 00 00    	je     9aa <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 8f7:	8d 45 10             	lea    0x10(%ebp),%eax
 8fa:	83 c6 01             	add    $0x1,%esi
  state = 0;
 8fd:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 8ff:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 902:	eb 2f                	jmp    933 <printf+0x53>
 904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 908:	83 f8 25             	cmp    $0x25,%eax
 90b:	0f 84 a7 00 00 00    	je     9b8 <printf+0xd8>
  write(fd, &c, 1);
 911:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 914:	83 ec 04             	sub    $0x4,%esp
 917:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 91a:	6a 01                	push   $0x1
 91c:	50                   	push   %eax
 91d:	ff 75 08             	pushl  0x8(%ebp)
 920:	e8 41 fe ff ff       	call   766 <write>
 925:	83 c4 10             	add    $0x10,%esp
 928:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 92b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 92f:	84 db                	test   %bl,%bl
 931:	74 77                	je     9aa <printf+0xca>
    if(state == 0){
 933:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 935:	0f be cb             	movsbl %bl,%ecx
 938:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 93b:	74 cb                	je     908 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 93d:	83 ff 25             	cmp    $0x25,%edi
 940:	75 e6                	jne    928 <printf+0x48>
      if(c == 'd'){
 942:	83 f8 64             	cmp    $0x64,%eax
 945:	0f 84 05 01 00 00    	je     a50 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 94b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 951:	83 f9 70             	cmp    $0x70,%ecx
 954:	74 72                	je     9c8 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 956:	83 f8 73             	cmp    $0x73,%eax
 959:	0f 84 99 00 00 00    	je     9f8 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 95f:	83 f8 63             	cmp    $0x63,%eax
 962:	0f 84 08 01 00 00    	je     a70 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 968:	83 f8 25             	cmp    $0x25,%eax
 96b:	0f 84 ef 00 00 00    	je     a60 <printf+0x180>
  write(fd, &c, 1);
 971:	8d 45 e7             	lea    -0x19(%ebp),%eax
 974:	83 ec 04             	sub    $0x4,%esp
 977:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 97b:	6a 01                	push   $0x1
 97d:	50                   	push   %eax
 97e:	ff 75 08             	pushl  0x8(%ebp)
 981:	e8 e0 fd ff ff       	call   766 <write>
 986:	83 c4 0c             	add    $0xc,%esp
 989:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 98c:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 98f:	6a 01                	push   $0x1
 991:	50                   	push   %eax
 992:	ff 75 08             	pushl  0x8(%ebp)
 995:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 998:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 99a:	e8 c7 fd ff ff       	call   766 <write>
  for(i = 0; fmt[i]; i++){
 99f:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 9a3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 9a6:	84 db                	test   %bl,%bl
 9a8:	75 89                	jne    933 <printf+0x53>
    }
  }
}
 9aa:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9ad:	5b                   	pop    %ebx
 9ae:	5e                   	pop    %esi
 9af:	5f                   	pop    %edi
 9b0:	5d                   	pop    %ebp
 9b1:	c3                   	ret    
 9b2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 9b8:	bf 25 00 00 00       	mov    $0x25,%edi
 9bd:	e9 66 ff ff ff       	jmp    928 <printf+0x48>
 9c2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 9c8:	83 ec 0c             	sub    $0xc,%esp
 9cb:	b9 10 00 00 00       	mov    $0x10,%ecx
 9d0:	6a 00                	push   $0x0
 9d2:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 9d5:	8b 45 08             	mov    0x8(%ebp),%eax
 9d8:	8b 17                	mov    (%edi),%edx
 9da:	e8 61 fe ff ff       	call   840 <printint>
        ap++;
 9df:	89 f8                	mov    %edi,%eax
 9e1:	83 c4 10             	add    $0x10,%esp
      state = 0;
 9e4:	31 ff                	xor    %edi,%edi
        ap++;
 9e6:	83 c0 04             	add    $0x4,%eax
 9e9:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 9ec:	e9 37 ff ff ff       	jmp    928 <printf+0x48>
 9f1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 9f8:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 9fb:	8b 08                	mov    (%eax),%ecx
        ap++;
 9fd:	83 c0 04             	add    $0x4,%eax
 a00:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 a03:	85 c9                	test   %ecx,%ecx
 a05:	0f 84 8e 00 00 00    	je     a99 <printf+0x1b9>
        while(*s != 0){
 a0b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 a0e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 a10:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 a12:	84 c0                	test   %al,%al
 a14:	0f 84 0e ff ff ff    	je     928 <printf+0x48>
 a1a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 a1d:	89 de                	mov    %ebx,%esi
 a1f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a22:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 a25:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 a28:	83 ec 04             	sub    $0x4,%esp
          s++;
 a2b:	83 c6 01             	add    $0x1,%esi
 a2e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 a31:	6a 01                	push   $0x1
 a33:	57                   	push   %edi
 a34:	53                   	push   %ebx
 a35:	e8 2c fd ff ff       	call   766 <write>
        while(*s != 0){
 a3a:	0f b6 06             	movzbl (%esi),%eax
 a3d:	83 c4 10             	add    $0x10,%esp
 a40:	84 c0                	test   %al,%al
 a42:	75 e4                	jne    a28 <printf+0x148>
 a44:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 a47:	31 ff                	xor    %edi,%edi
 a49:	e9 da fe ff ff       	jmp    928 <printf+0x48>
 a4e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 a50:	83 ec 0c             	sub    $0xc,%esp
 a53:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a58:	6a 01                	push   $0x1
 a5a:	e9 73 ff ff ff       	jmp    9d2 <printf+0xf2>
 a5f:	90                   	nop
  write(fd, &c, 1);
 a60:	83 ec 04             	sub    $0x4,%esp
 a63:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 a66:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 a69:	6a 01                	push   $0x1
 a6b:	e9 21 ff ff ff       	jmp    991 <printf+0xb1>
        putc(fd, *ap);
 a70:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 a73:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 a76:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 a78:	6a 01                	push   $0x1
        ap++;
 a7a:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 a7d:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 a80:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 a83:	50                   	push   %eax
 a84:	ff 75 08             	pushl  0x8(%ebp)
 a87:	e8 da fc ff ff       	call   766 <write>
        ap++;
 a8c:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 a8f:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a92:	31 ff                	xor    %edi,%edi
 a94:	e9 8f fe ff ff       	jmp    928 <printf+0x48>
          s = "(null)";
 a99:	bb b2 0c 00 00       	mov    $0xcb2,%ebx
        while(*s != 0){
 a9e:	b8 28 00 00 00       	mov    $0x28,%eax
 aa3:	e9 72 ff ff ff       	jmp    a1a <printf+0x13a>
 aa8:	66 90                	xchg   %ax,%ax
 aaa:	66 90                	xchg   %ax,%ax
 aac:	66 90                	xchg   %ax,%ax
 aae:	66 90                	xchg   %ax,%ax

00000ab0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 ab0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ab1:	a1 30 10 00 00       	mov    0x1030,%eax
{
 ab6:	89 e5                	mov    %esp,%ebp
 ab8:	57                   	push   %edi
 ab9:	56                   	push   %esi
 aba:	53                   	push   %ebx
 abb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 abe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 ac1:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 ac8:	39 c8                	cmp    %ecx,%eax
 aca:	8b 10                	mov    (%eax),%edx
 acc:	73 32                	jae    b00 <free+0x50>
 ace:	39 d1                	cmp    %edx,%ecx
 ad0:	72 04                	jb     ad6 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 ad2:	39 d0                	cmp    %edx,%eax
 ad4:	72 32                	jb     b08 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 ad6:	8b 73 fc             	mov    -0x4(%ebx),%esi
 ad9:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 adc:	39 fa                	cmp    %edi,%edx
 ade:	74 30                	je     b10 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 ae0:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 ae3:	8b 50 04             	mov    0x4(%eax),%edx
 ae6:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 ae9:	39 f1                	cmp    %esi,%ecx
 aeb:	74 3a                	je     b27 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 aed:	89 08                	mov    %ecx,(%eax)
  freep = p;
 aef:	a3 30 10 00 00       	mov    %eax,0x1030
}
 af4:	5b                   	pop    %ebx
 af5:	5e                   	pop    %esi
 af6:	5f                   	pop    %edi
 af7:	5d                   	pop    %ebp
 af8:	c3                   	ret    
 af9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b00:	39 d0                	cmp    %edx,%eax
 b02:	72 04                	jb     b08 <free+0x58>
 b04:	39 d1                	cmp    %edx,%ecx
 b06:	72 ce                	jb     ad6 <free+0x26>
{
 b08:	89 d0                	mov    %edx,%eax
 b0a:	eb bc                	jmp    ac8 <free+0x18>
 b0c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 b10:	03 72 04             	add    0x4(%edx),%esi
 b13:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b16:	8b 10                	mov    (%eax),%edx
 b18:	8b 12                	mov    (%edx),%edx
 b1a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b1d:	8b 50 04             	mov    0x4(%eax),%edx
 b20:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b23:	39 f1                	cmp    %esi,%ecx
 b25:	75 c6                	jne    aed <free+0x3d>
    p->s.size += bp->s.size;
 b27:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 b2a:	a3 30 10 00 00       	mov    %eax,0x1030
    p->s.size += bp->s.size;
 b2f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b32:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b35:	89 10                	mov    %edx,(%eax)
}
 b37:	5b                   	pop    %ebx
 b38:	5e                   	pop    %esi
 b39:	5f                   	pop    %edi
 b3a:	5d                   	pop    %ebp
 b3b:	c3                   	ret    
 b3c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b40 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b40:	55                   	push   %ebp
 b41:	89 e5                	mov    %esp,%ebp
 b43:	57                   	push   %edi
 b44:	56                   	push   %esi
 b45:	53                   	push   %ebx
 b46:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b49:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b4c:	8b 15 30 10 00 00    	mov    0x1030,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b52:	8d 78 07             	lea    0x7(%eax),%edi
 b55:	c1 ef 03             	shr    $0x3,%edi
 b58:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b5b:	85 d2                	test   %edx,%edx
 b5d:	0f 84 9d 00 00 00    	je     c00 <malloc+0xc0>
 b63:	8b 02                	mov    (%edx),%eax
 b65:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 b68:	39 cf                	cmp    %ecx,%edi
 b6a:	76 6c                	jbe    bd8 <malloc+0x98>
 b6c:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 b72:	bb 00 10 00 00       	mov    $0x1000,%ebx
 b77:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 b7a:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 b81:	eb 0e                	jmp    b91 <malloc+0x51>
 b83:	90                   	nop
 b84:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 b88:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 b8a:	8b 48 04             	mov    0x4(%eax),%ecx
 b8d:	39 f9                	cmp    %edi,%ecx
 b8f:	73 47                	jae    bd8 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 b91:	39 05 30 10 00 00    	cmp    %eax,0x1030
 b97:	89 c2                	mov    %eax,%edx
 b99:	75 ed                	jne    b88 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 b9b:	83 ec 0c             	sub    $0xc,%esp
 b9e:	56                   	push   %esi
 b9f:	e8 2a fc ff ff       	call   7ce <sbrk>
  if(p == (char*)-1)
 ba4:	83 c4 10             	add    $0x10,%esp
 ba7:	83 f8 ff             	cmp    $0xffffffff,%eax
 baa:	74 1c                	je     bc8 <malloc+0x88>
  hp->s.size = nu;
 bac:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 baf:	83 ec 0c             	sub    $0xc,%esp
 bb2:	83 c0 08             	add    $0x8,%eax
 bb5:	50                   	push   %eax
 bb6:	e8 f5 fe ff ff       	call   ab0 <free>
  return freep;
 bbb:	8b 15 30 10 00 00    	mov    0x1030,%edx
      if((p = morecore(nunits)) == 0)
 bc1:	83 c4 10             	add    $0x10,%esp
 bc4:	85 d2                	test   %edx,%edx
 bc6:	75 c0                	jne    b88 <malloc+0x48>
        return 0;
  }
}
 bc8:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 bcb:	31 c0                	xor    %eax,%eax
}
 bcd:	5b                   	pop    %ebx
 bce:	5e                   	pop    %esi
 bcf:	5f                   	pop    %edi
 bd0:	5d                   	pop    %ebp
 bd1:	c3                   	ret    
 bd2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 bd8:	39 cf                	cmp    %ecx,%edi
 bda:	74 54                	je     c30 <malloc+0xf0>
        p->s.size -= nunits;
 bdc:	29 f9                	sub    %edi,%ecx
 bde:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 be1:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 be4:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 be7:	89 15 30 10 00 00    	mov    %edx,0x1030
}
 bed:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 bf0:	83 c0 08             	add    $0x8,%eax
}
 bf3:	5b                   	pop    %ebx
 bf4:	5e                   	pop    %esi
 bf5:	5f                   	pop    %edi
 bf6:	5d                   	pop    %ebp
 bf7:	c3                   	ret    
 bf8:	90                   	nop
 bf9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 c00:	c7 05 30 10 00 00 34 	movl   $0x1034,0x1030
 c07:	10 00 00 
 c0a:	c7 05 34 10 00 00 34 	movl   $0x1034,0x1034
 c11:	10 00 00 
    base.s.size = 0;
 c14:	b8 34 10 00 00       	mov    $0x1034,%eax
 c19:	c7 05 38 10 00 00 00 	movl   $0x0,0x1038
 c20:	00 00 00 
 c23:	e9 44 ff ff ff       	jmp    b6c <malloc+0x2c>
 c28:	90                   	nop
 c29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 c30:	8b 08                	mov    (%eax),%ecx
 c32:	89 0a                	mov    %ecx,(%edx)
 c34:	eb b1                	jmp    be7 <malloc+0xa7>
