
_wc:     file format elf32-i386


Disassembly of section .text:

00000000 <main>:
  printf(1, "%d %d %d %s\n", l, w, c, name);
}

int
main(int argc, char *argv[])
{
   0:	8d 4c 24 04          	lea    0x4(%esp),%ecx
   4:	83 e4 f0             	and    $0xfffffff0,%esp
   7:	ff 71 fc             	pushl  -0x4(%ecx)
   a:	55                   	push   %ebp
   b:	89 e5                	mov    %esp,%ebp
   d:	57                   	push   %edi
   e:	56                   	push   %esi
   f:	53                   	push   %ebx
  10:	51                   	push   %ecx
  11:	be 01 00 00 00       	mov    $0x1,%esi
  16:	83 ec 18             	sub    $0x18,%esp
  19:	8b 01                	mov    (%ecx),%eax
  1b:	8b 59 04             	mov    0x4(%ecx),%ebx
  1e:	83 c3 04             	add    $0x4,%ebx
  int fd, i;

  if(argc <= 1){
  21:	83 f8 01             	cmp    $0x1,%eax
{
  24:	89 45 e4             	mov    %eax,-0x1c(%ebp)
  if(argc <= 1){
  27:	7e 56                	jle    7f <main+0x7f>
  29:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    wc(0, "");
    exit();
  }

  for(i = 1; i < argc; i++){
    if((fd = open(argv[i], 0)) < 0){
  30:	83 ec 08             	sub    $0x8,%esp
  33:	6a 00                	push   $0x0
  35:	ff 33                	pushl  (%ebx)
  37:	e8 8a 07 00 00       	call   7c6 <open>
  3c:	83 c4 10             	add    $0x10,%esp
  3f:	85 c0                	test   %eax,%eax
  41:	89 c7                	mov    %eax,%edi
  43:	78 26                	js     6b <main+0x6b>
      printf(1, "wc: cannot open %s\n", argv[i]);
      exit();
    }
    wc(fd, argv[i]);
  45:	83 ec 08             	sub    $0x8,%esp
  48:	ff 33                	pushl  (%ebx)
  for(i = 1; i < argc; i++){
  4a:	83 c6 01             	add    $0x1,%esi
    wc(fd, argv[i]);
  4d:	50                   	push   %eax
  4e:	83 c3 04             	add    $0x4,%ebx
  51:	e8 4a 00 00 00       	call   a0 <wc>
    close(fd);
  56:	89 3c 24             	mov    %edi,(%esp)
  59:	e8 50 07 00 00       	call   7ae <close>
  for(i = 1; i < argc; i++){
  5e:	83 c4 10             	add    $0x10,%esp
  61:	39 75 e4             	cmp    %esi,-0x1c(%ebp)
  64:	75 ca                	jne    30 <main+0x30>
  }
  exit();
  66:	e8 1b 07 00 00       	call   786 <exit>
      printf(1, "wc: cannot open %s\n", argv[i]);
  6b:	50                   	push   %eax
  6c:	ff 33                	pushl  (%ebx)
  6e:	68 9b 0c 00 00       	push   $0xc9b
  73:	6a 01                	push   $0x1
  75:	e8 a6 08 00 00       	call   920 <printf>
      exit();
  7a:	e8 07 07 00 00       	call   786 <exit>
    wc(0, "");
  7f:	52                   	push   %edx
  80:	52                   	push   %edx
  81:	68 ba 0c 00 00       	push   $0xcba
  86:	6a 00                	push   $0x0
  88:	e8 13 00 00 00       	call   a0 <wc>
    exit();
  8d:	e8 f4 06 00 00       	call   786 <exit>
  92:	66 90                	xchg   %ax,%ax
  94:	66 90                	xchg   %ax,%ax
  96:	66 90                	xchg   %ax,%ax
  98:	66 90                	xchg   %ax,%ax
  9a:	66 90                	xchg   %ax,%ax
  9c:	66 90                	xchg   %ax,%ax
  9e:	66 90                	xchg   %ax,%ax

000000a0 <wc>:
{
  a0:	55                   	push   %ebp
  a1:	89 e5                	mov    %esp,%ebp
  a3:	57                   	push   %edi
  a4:	56                   	push   %esi
  a5:	53                   	push   %ebx
  l = w = c = 0;
  a6:	31 db                	xor    %ebx,%ebx
{
  a8:	83 ec 1c             	sub    $0x1c,%esp
  inword = 0;
  ab:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
  l = w = c = 0;
  b2:	c7 45 e0 00 00 00 00 	movl   $0x0,-0x20(%ebp)
  b9:	c7 45 dc 00 00 00 00 	movl   $0x0,-0x24(%ebp)
  while((n = read(fd, buf, sizeof(buf))) > 0){
  c0:	83 ec 04             	sub    $0x4,%esp
  c3:	68 00 02 00 00       	push   $0x200
  c8:	68 20 7e 03 00       	push   $0x37e20
  cd:	ff 75 08             	pushl  0x8(%ebp)
  d0:	e8 c9 06 00 00       	call   79e <read>
  d5:	83 c4 10             	add    $0x10,%esp
  d8:	83 f8 00             	cmp    $0x0,%eax
  db:	89 c6                	mov    %eax,%esi
  dd:	7e 61                	jle    140 <wc+0xa0>
    for(i=0; i<n; i++){
  df:	31 ff                	xor    %edi,%edi
  e1:	eb 13                	jmp    f6 <wc+0x56>
  e3:	90                   	nop
  e4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        inword = 0;
  e8:	c7 45 e4 00 00 00 00 	movl   $0x0,-0x1c(%ebp)
    for(i=0; i<n; i++){
  ef:	83 c7 01             	add    $0x1,%edi
  f2:	39 fe                	cmp    %edi,%esi
  f4:	74 42                	je     138 <wc+0x98>
      if(buf[i] == '\n')
  f6:	0f be 87 20 7e 03 00 	movsbl 0x37e20(%edi),%eax
        l++;
  fd:	31 c9                	xor    %ecx,%ecx
  ff:	3c 0a                	cmp    $0xa,%al
 101:	0f 94 c1             	sete   %cl
      if(strchr(" \r\t\n\v", buf[i]))
 104:	83 ec 08             	sub    $0x8,%esp
 107:	50                   	push   %eax
 108:	68 78 0c 00 00       	push   $0xc78
        l++;
 10d:	01 cb                	add    %ecx,%ebx
      if(strchr(" \r\t\n\v", buf[i]))
 10f:	e8 3c 01 00 00       	call   250 <strchr>
 114:	83 c4 10             	add    $0x10,%esp
 117:	85 c0                	test   %eax,%eax
 119:	75 cd                	jne    e8 <wc+0x48>
      else if(!inword){
 11b:	8b 55 e4             	mov    -0x1c(%ebp),%edx
 11e:	85 d2                	test   %edx,%edx
 120:	75 cd                	jne    ef <wc+0x4f>
    for(i=0; i<n; i++){
 122:	83 c7 01             	add    $0x1,%edi
        w++;
 125:	83 45 dc 01          	addl   $0x1,-0x24(%ebp)
        inword = 1;
 129:	c7 45 e4 01 00 00 00 	movl   $0x1,-0x1c(%ebp)
    for(i=0; i<n; i++){
 130:	39 fe                	cmp    %edi,%esi
 132:	75 c2                	jne    f6 <wc+0x56>
 134:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 138:	01 75 e0             	add    %esi,-0x20(%ebp)
 13b:	eb 83                	jmp    c0 <wc+0x20>
 13d:	8d 76 00             	lea    0x0(%esi),%esi
  if(n < 0){
 140:	75 24                	jne    166 <wc+0xc6>
  printf(1, "%d %d %d %s\n", l, w, c, name);
 142:	83 ec 08             	sub    $0x8,%esp
 145:	ff 75 0c             	pushl  0xc(%ebp)
 148:	ff 75 e0             	pushl  -0x20(%ebp)
 14b:	ff 75 dc             	pushl  -0x24(%ebp)
 14e:	53                   	push   %ebx
 14f:	68 8e 0c 00 00       	push   $0xc8e
 154:	6a 01                	push   $0x1
 156:	e8 c5 07 00 00       	call   920 <printf>
}
 15b:	83 c4 20             	add    $0x20,%esp
 15e:	8d 65 f4             	lea    -0xc(%ebp),%esp
 161:	5b                   	pop    %ebx
 162:	5e                   	pop    %esi
 163:	5f                   	pop    %edi
 164:	5d                   	pop    %ebp
 165:	c3                   	ret    
    printf(1, "wc: read error\n");
 166:	50                   	push   %eax
 167:	50                   	push   %eax
 168:	68 7e 0c 00 00       	push   $0xc7e
 16d:	6a 01                	push   $0x1
 16f:	e8 ac 07 00 00       	call   920 <printf>
    exit();
 174:	e8 0d 06 00 00       	call   786 <exit>
 179:	66 90                	xchg   %ax,%ax
 17b:	66 90                	xchg   %ax,%ax
 17d:	66 90                	xchg   %ax,%ax
 17f:	90                   	nop

00000180 <strcpy>:
#include "user.h"
#include "x86.h"

char*
strcpy(char *s, const char *t)
{
 180:	55                   	push   %ebp
 181:	89 e5                	mov    %esp,%ebp
 183:	53                   	push   %ebx
 184:	8b 45 08             	mov    0x8(%ebp),%eax
 187:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  char *os;

  os = s;
  while((*s++ = *t++) != 0)
 18a:	89 c2                	mov    %eax,%edx
 18c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 190:	83 c1 01             	add    $0x1,%ecx
 193:	0f b6 59 ff          	movzbl -0x1(%ecx),%ebx
 197:	83 c2 01             	add    $0x1,%edx
 19a:	84 db                	test   %bl,%bl
 19c:	88 5a ff             	mov    %bl,-0x1(%edx)
 19f:	75 ef                	jne    190 <strcpy+0x10>
    ;
  return os;
}
 1a1:	5b                   	pop    %ebx
 1a2:	5d                   	pop    %ebp
 1a3:	c3                   	ret    
 1a4:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 1aa:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

000001b0 <strcmp>:

int
strcmp(const char *p, const char *q)
{
 1b0:	55                   	push   %ebp
 1b1:	89 e5                	mov    %esp,%ebp
 1b3:	53                   	push   %ebx
 1b4:	8b 55 08             	mov    0x8(%ebp),%edx
 1b7:	8b 4d 0c             	mov    0xc(%ebp),%ecx
  while(*p && *p == *q)
 1ba:	0f b6 02             	movzbl (%edx),%eax
 1bd:	0f b6 19             	movzbl (%ecx),%ebx
 1c0:	84 c0                	test   %al,%al
 1c2:	75 1c                	jne    1e0 <strcmp+0x30>
 1c4:	eb 2a                	jmp    1f0 <strcmp+0x40>
 1c6:	8d 76 00             	lea    0x0(%esi),%esi
 1c9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    p++, q++;
 1d0:	83 c2 01             	add    $0x1,%edx
  while(*p && *p == *q)
 1d3:	0f b6 02             	movzbl (%edx),%eax
    p++, q++;
 1d6:	83 c1 01             	add    $0x1,%ecx
 1d9:	0f b6 19             	movzbl (%ecx),%ebx
  while(*p && *p == *q)
 1dc:	84 c0                	test   %al,%al
 1de:	74 10                	je     1f0 <strcmp+0x40>
 1e0:	38 d8                	cmp    %bl,%al
 1e2:	74 ec                	je     1d0 <strcmp+0x20>
  return (uchar)*p - (uchar)*q;
 1e4:	29 d8                	sub    %ebx,%eax
}
 1e6:	5b                   	pop    %ebx
 1e7:	5d                   	pop    %ebp
 1e8:	c3                   	ret    
 1e9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 1f0:	31 c0                	xor    %eax,%eax
  return (uchar)*p - (uchar)*q;
 1f2:	29 d8                	sub    %ebx,%eax
}
 1f4:	5b                   	pop    %ebx
 1f5:	5d                   	pop    %ebp
 1f6:	c3                   	ret    
 1f7:	89 f6                	mov    %esi,%esi
 1f9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000200 <strlen>:

uint
strlen(const char *s)
{
 200:	55                   	push   %ebp
 201:	89 e5                	mov    %esp,%ebp
 203:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  for(n = 0; s[n]; n++)
 206:	80 39 00             	cmpb   $0x0,(%ecx)
 209:	74 15                	je     220 <strlen+0x20>
 20b:	31 d2                	xor    %edx,%edx
 20d:	8d 76 00             	lea    0x0(%esi),%esi
 210:	83 c2 01             	add    $0x1,%edx
 213:	80 3c 11 00          	cmpb   $0x0,(%ecx,%edx,1)
 217:	89 d0                	mov    %edx,%eax
 219:	75 f5                	jne    210 <strlen+0x10>
    ;
  return n;
}
 21b:	5d                   	pop    %ebp
 21c:	c3                   	ret    
 21d:	8d 76 00             	lea    0x0(%esi),%esi
  for(n = 0; s[n]; n++)
 220:	31 c0                	xor    %eax,%eax
}
 222:	5d                   	pop    %ebp
 223:	c3                   	ret    
 224:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 22a:	8d bf 00 00 00 00    	lea    0x0(%edi),%edi

00000230 <memset>:

void*
memset(void *dst, int c, uint n)
{
 230:	55                   	push   %ebp
 231:	89 e5                	mov    %esp,%ebp
 233:	57                   	push   %edi
 234:	8b 55 08             	mov    0x8(%ebp),%edx
}

static inline void
stosb(void *addr, int data, int cnt)
{
  asm volatile("cld; rep stosb" :
 237:	8b 4d 10             	mov    0x10(%ebp),%ecx
 23a:	8b 45 0c             	mov    0xc(%ebp),%eax
 23d:	89 d7                	mov    %edx,%edi
 23f:	fc                   	cld    
 240:	f3 aa                	rep stos %al,%es:(%edi)
  stosb(dst, c, n);
  return dst;
}
 242:	89 d0                	mov    %edx,%eax
 244:	5f                   	pop    %edi
 245:	5d                   	pop    %ebp
 246:	c3                   	ret    
 247:	89 f6                	mov    %esi,%esi
 249:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000250 <strchr>:

char*
strchr(const char *s, char c)
{
 250:	55                   	push   %ebp
 251:	89 e5                	mov    %esp,%ebp
 253:	53                   	push   %ebx
 254:	8b 45 08             	mov    0x8(%ebp),%eax
 257:	8b 5d 0c             	mov    0xc(%ebp),%ebx
  for(; *s; s++)
 25a:	0f b6 10             	movzbl (%eax),%edx
 25d:	84 d2                	test   %dl,%dl
 25f:	74 1d                	je     27e <strchr+0x2e>
    if(*s == c)
 261:	38 d3                	cmp    %dl,%bl
 263:	89 d9                	mov    %ebx,%ecx
 265:	75 0d                	jne    274 <strchr+0x24>
 267:	eb 17                	jmp    280 <strchr+0x30>
 269:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
 270:	38 ca                	cmp    %cl,%dl
 272:	74 0c                	je     280 <strchr+0x30>
  for(; *s; s++)
 274:	83 c0 01             	add    $0x1,%eax
 277:	0f b6 10             	movzbl (%eax),%edx
 27a:	84 d2                	test   %dl,%dl
 27c:	75 f2                	jne    270 <strchr+0x20>
      return (char*)s;
  return 0;
 27e:	31 c0                	xor    %eax,%eax
}
 280:	5b                   	pop    %ebx
 281:	5d                   	pop    %ebp
 282:	c3                   	ret    
 283:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 289:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000290 <gets>:

char*
gets(char *buf, int max)
{
 290:	55                   	push   %ebp
 291:	89 e5                	mov    %esp,%ebp
 293:	57                   	push   %edi
 294:	56                   	push   %esi
 295:	53                   	push   %ebx
  int i, cc;
  char c;

  for(i=0; i+1 < max; ){
 296:	31 f6                	xor    %esi,%esi
 298:	89 f3                	mov    %esi,%ebx
{
 29a:	83 ec 1c             	sub    $0x1c,%esp
 29d:	8b 7d 08             	mov    0x8(%ebp),%edi
  for(i=0; i+1 < max; ){
 2a0:	eb 2f                	jmp    2d1 <gets+0x41>
 2a2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
    cc = read(0, &c, 1);
 2a8:	8d 45 e7             	lea    -0x19(%ebp),%eax
 2ab:	83 ec 04             	sub    $0x4,%esp
 2ae:	6a 01                	push   $0x1
 2b0:	50                   	push   %eax
 2b1:	6a 00                	push   $0x0
 2b3:	e8 e6 04 00 00       	call   79e <read>
    if(cc < 1)
 2b8:	83 c4 10             	add    $0x10,%esp
 2bb:	85 c0                	test   %eax,%eax
 2bd:	7e 1c                	jle    2db <gets+0x4b>
      break;
    buf[i++] = c;
 2bf:	0f b6 45 e7          	movzbl -0x19(%ebp),%eax
 2c3:	83 c7 01             	add    $0x1,%edi
 2c6:	88 47 ff             	mov    %al,-0x1(%edi)
    if(c == '\n' || c == '\r')
 2c9:	3c 0a                	cmp    $0xa,%al
 2cb:	74 23                	je     2f0 <gets+0x60>
 2cd:	3c 0d                	cmp    $0xd,%al
 2cf:	74 1f                	je     2f0 <gets+0x60>
  for(i=0; i+1 < max; ){
 2d1:	83 c3 01             	add    $0x1,%ebx
 2d4:	3b 5d 0c             	cmp    0xc(%ebp),%ebx
 2d7:	89 fe                	mov    %edi,%esi
 2d9:	7c cd                	jl     2a8 <gets+0x18>
 2db:	89 f3                	mov    %esi,%ebx
      break;
  }
  buf[i] = '\0';
  return buf;
}
 2dd:	8b 45 08             	mov    0x8(%ebp),%eax
  buf[i] = '\0';
 2e0:	c6 03 00             	movb   $0x0,(%ebx)
}
 2e3:	8d 65 f4             	lea    -0xc(%ebp),%esp
 2e6:	5b                   	pop    %ebx
 2e7:	5e                   	pop    %esi
 2e8:	5f                   	pop    %edi
 2e9:	5d                   	pop    %ebp
 2ea:	c3                   	ret    
 2eb:	90                   	nop
 2ec:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 2f0:	8b 75 08             	mov    0x8(%ebp),%esi
 2f3:	8b 45 08             	mov    0x8(%ebp),%eax
 2f6:	01 de                	add    %ebx,%esi
 2f8:	89 f3                	mov    %esi,%ebx
  buf[i] = '\0';
 2fa:	c6 03 00             	movb   $0x0,(%ebx)
}
 2fd:	8d 65 f4             	lea    -0xc(%ebp),%esp
 300:	5b                   	pop    %ebx
 301:	5e                   	pop    %esi
 302:	5f                   	pop    %edi
 303:	5d                   	pop    %ebp
 304:	c3                   	ret    
 305:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 309:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000310 <stat>:

int
stat(const char *n, struct stat *st)
{
 310:	55                   	push   %ebp
 311:	89 e5                	mov    %esp,%ebp
 313:	56                   	push   %esi
 314:	53                   	push   %ebx
  int fd;
  int r;

  fd = open(n, O_RDONLY);
 315:	83 ec 08             	sub    $0x8,%esp
 318:	6a 00                	push   $0x0
 31a:	ff 75 08             	pushl  0x8(%ebp)
 31d:	e8 a4 04 00 00       	call   7c6 <open>
  if(fd < 0)
 322:	83 c4 10             	add    $0x10,%esp
 325:	85 c0                	test   %eax,%eax
 327:	78 27                	js     350 <stat+0x40>
    return -1;
  r = fstat(fd, st);
 329:	83 ec 08             	sub    $0x8,%esp
 32c:	ff 75 0c             	pushl  0xc(%ebp)
 32f:	89 c3                	mov    %eax,%ebx
 331:	50                   	push   %eax
 332:	e8 a7 04 00 00       	call   7de <fstat>
  close(fd);
 337:	89 1c 24             	mov    %ebx,(%esp)
  r = fstat(fd, st);
 33a:	89 c6                	mov    %eax,%esi
  close(fd);
 33c:	e8 6d 04 00 00       	call   7ae <close>
  return r;
 341:	83 c4 10             	add    $0x10,%esp
}
 344:	8d 65 f8             	lea    -0x8(%ebp),%esp
 347:	89 f0                	mov    %esi,%eax
 349:	5b                   	pop    %ebx
 34a:	5e                   	pop    %esi
 34b:	5d                   	pop    %ebp
 34c:	c3                   	ret    
 34d:	8d 76 00             	lea    0x0(%esi),%esi
    return -1;
 350:	be ff ff ff ff       	mov    $0xffffffff,%esi
 355:	eb ed                	jmp    344 <stat+0x34>
 357:	89 f6                	mov    %esi,%esi
 359:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

00000360 <atoi>:

int
atoi(const char *s)
{
 360:	55                   	push   %ebp
 361:	89 e5                	mov    %esp,%ebp
 363:	53                   	push   %ebx
 364:	8b 4d 08             	mov    0x8(%ebp),%ecx
  int n;

  n = 0;
  while('0' <= *s && *s <= '9')
 367:	0f be 11             	movsbl (%ecx),%edx
 36a:	8d 42 d0             	lea    -0x30(%edx),%eax
 36d:	3c 09                	cmp    $0x9,%al
  n = 0;
 36f:	b8 00 00 00 00       	mov    $0x0,%eax
  while('0' <= *s && *s <= '9')
 374:	77 1f                	ja     395 <atoi+0x35>
 376:	8d 76 00             	lea    0x0(%esi),%esi
 379:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi
    n = n*10 + *s++ - '0';
 380:	8d 04 80             	lea    (%eax,%eax,4),%eax
 383:	83 c1 01             	add    $0x1,%ecx
 386:	8d 44 42 d0          	lea    -0x30(%edx,%eax,2),%eax
  while('0' <= *s && *s <= '9')
 38a:	0f be 11             	movsbl (%ecx),%edx
 38d:	8d 5a d0             	lea    -0x30(%edx),%ebx
 390:	80 fb 09             	cmp    $0x9,%bl
 393:	76 eb                	jbe    380 <atoi+0x20>
  return n;
}
 395:	5b                   	pop    %ebx
 396:	5d                   	pop    %ebp
 397:	c3                   	ret    
 398:	90                   	nop
 399:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi

000003a0 <memmove>:

void*
memmove(void *vdst, const void *vsrc, int n)
{
 3a0:	55                   	push   %ebp
 3a1:	89 e5                	mov    %esp,%ebp
 3a3:	56                   	push   %esi
 3a4:	53                   	push   %ebx
 3a5:	8b 5d 10             	mov    0x10(%ebp),%ebx
 3a8:	8b 45 08             	mov    0x8(%ebp),%eax
 3ab:	8b 75 0c             	mov    0xc(%ebp),%esi
  char *dst;
  const char *src;

  dst = vdst;
  src = vsrc;
  while(n-- > 0)
 3ae:	85 db                	test   %ebx,%ebx
 3b0:	7e 14                	jle    3c6 <memmove+0x26>
 3b2:	31 d2                	xor    %edx,%edx
 3b4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    *dst++ = *src++;
 3b8:	0f b6 0c 16          	movzbl (%esi,%edx,1),%ecx
 3bc:	88 0c 10             	mov    %cl,(%eax,%edx,1)
 3bf:	83 c2 01             	add    $0x1,%edx
  while(n-- > 0)
 3c2:	39 d3                	cmp    %edx,%ebx
 3c4:	75 f2                	jne    3b8 <memmove+0x18>
  return vdst;
}
 3c6:	5b                   	pop    %ebx
 3c7:	5e                   	pop    %esi
 3c8:	5d                   	pop    %ebp
 3c9:	c3                   	ret    
 3ca:	66 90                	xchg   %ax,%ax
 3cc:	66 90                	xchg   %ax,%ax
 3ce:	66 90                	xchg   %ax,%ax

000003d0 <mystrcmp>:
#include "ls.h"
// #include "defs.h"

int
mystrcmp (char *s1, char *s2)
{
 3d0:	55                   	push   %ebp
 3d1:	89 e5                	mov    %esp,%ebp
 3d3:	56                   	push   %esi
 3d4:	53                   	push   %ebx
 3d5:	8b 4d 08             	mov    0x8(%ebp),%ecx
    int a =0,b=0;
 3d8:	31 db                	xor    %ebx,%ebx
{
 3da:	8b 55 0c             	mov    0xc(%ebp),%edx
    while(*s1){a++;s1++;}
 3dd:	80 39 00             	cmpb   $0x0,(%ecx)
 3e0:	0f b6 02             	movzbl (%edx),%eax
 3e3:	74 33                	je     418 <mystrcmp+0x48>
 3e5:	8d 76 00             	lea    0x0(%esi),%esi
 3e8:	83 c1 01             	add    $0x1,%ecx
 3eb:	83 c3 01             	add    $0x1,%ebx
 3ee:	80 39 00             	cmpb   $0x0,(%ecx)
 3f1:	75 f5                	jne    3e8 <mystrcmp+0x18>
    while(*s2){b++;s2++;}
 3f3:	84 c0                	test   %al,%al
 3f5:	74 51                	je     448 <mystrcmp+0x78>
    int a =0,b=0;
 3f7:	31 f6                	xor    %esi,%esi
 3f9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    while(*s2){b++;s2++;}
 400:	83 c2 01             	add    $0x1,%edx
 403:	83 c6 01             	add    $0x1,%esi
 406:	80 3a 00             	cmpb   $0x0,(%edx)
 409:	75 f5                	jne    400 <mystrcmp+0x30>

    if(a!=b)return 0;
 40b:	31 c0                	xor    %eax,%eax
 40d:	39 de                	cmp    %ebx,%esi
 40f:	74 0f                	je     420 <mystrcmp+0x50>
    // printf("here");
    while(a--){
        if(*s1++ != *s2++)return 0;
    }
    return 1;
}
 411:	5b                   	pop    %ebx
 412:	5e                   	pop    %esi
 413:	5d                   	pop    %ebp
 414:	c3                   	ret    
 415:	8d 76 00             	lea    0x0(%esi),%esi
    while(*s2){b++;s2++;}
 418:	84 c0                	test   %al,%al
 41a:	75 db                	jne    3f7 <mystrcmp+0x27>
 41c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 420:	01 d3                	add    %edx,%ebx
 422:	eb 13                	jmp    437 <mystrcmp+0x67>
 424:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
        if(*s1++ != *s2++)return 0;
 428:	83 c2 01             	add    $0x1,%edx
 42b:	83 c1 01             	add    $0x1,%ecx
 42e:	0f b6 42 ff          	movzbl -0x1(%edx),%eax
 432:	38 41 ff             	cmp    %al,-0x1(%ecx)
 435:	75 11                	jne    448 <mystrcmp+0x78>
    while(a--){
 437:	39 d3                	cmp    %edx,%ebx
 439:	75 ed                	jne    428 <mystrcmp+0x58>
}
 43b:	5b                   	pop    %ebx
    return 1;
 43c:	b8 01 00 00 00       	mov    $0x1,%eax
}
 441:	5e                   	pop    %esi
 442:	5d                   	pop    %ebp
 443:	c3                   	ret    
 444:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
 448:	5b                   	pop    %ebx
    if(a!=b)return 0;
 449:	31 c0                	xor    %eax,%eax
}
 44b:	5e                   	pop    %esi
 44c:	5d                   	pop    %ebp
 44d:	c3                   	ret    
 44e:	66 90                	xchg   %ax,%ax

00000450 <fmtname>:

char*
fmtname(char *path)
{
 450:	55                   	push   %ebp
 451:	89 e5                	mov    %esp,%ebp
 453:	56                   	push   %esi
 454:	53                   	push   %ebx
 455:	8b 5d 08             	mov    0x8(%ebp),%ebx
  static char buf[DIRSIZ+1];
  char *p;

  // Find first character after last slash.
  for(p=path+strlen(path); p >= path && *p != '/'; p--)
 458:	83 ec 0c             	sub    $0xc,%esp
 45b:	53                   	push   %ebx
 45c:	e8 9f fd ff ff       	call   200 <strlen>
 461:	83 c4 10             	add    $0x10,%esp
 464:	01 d8                	add    %ebx,%eax
 466:	73 0f                	jae    477 <fmtname+0x27>
 468:	eb 12                	jmp    47c <fmtname+0x2c>
 46a:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 470:	83 e8 01             	sub    $0x1,%eax
 473:	39 c3                	cmp    %eax,%ebx
 475:	77 05                	ja     47c <fmtname+0x2c>
 477:	80 38 2f             	cmpb   $0x2f,(%eax)
 47a:	75 f4                	jne    470 <fmtname+0x20>
    ;
  p++;
 47c:	8d 58 01             	lea    0x1(%eax),%ebx

  // Return blank-padded name.
  if(strlen(p) >= DIRSIZ)
 47f:	83 ec 0c             	sub    $0xc,%esp
 482:	53                   	push   %ebx
 483:	e8 78 fd ff ff       	call   200 <strlen>
 488:	83 c4 10             	add    $0x10,%esp
 48b:	83 f8 0d             	cmp    $0xd,%eax
 48e:	77 4a                	ja     4da <fmtname+0x8a>
    return p;
  memmove(buf, p, strlen(p));
 490:	83 ec 0c             	sub    $0xc,%esp
 493:	53                   	push   %ebx
 494:	e8 67 fd ff ff       	call   200 <strlen>
 499:	83 c4 0c             	add    $0xc,%esp
 49c:	50                   	push   %eax
 49d:	53                   	push   %ebx
 49e:	68 c0 10 00 00       	push   $0x10c0
 4a3:	e8 f8 fe ff ff       	call   3a0 <memmove>
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 4a8:	89 1c 24             	mov    %ebx,(%esp)
 4ab:	e8 50 fd ff ff       	call   200 <strlen>
 4b0:	89 1c 24             	mov    %ebx,(%esp)
 4b3:	89 c6                	mov    %eax,%esi
  return buf;
 4b5:	bb c0 10 00 00       	mov    $0x10c0,%ebx
  memset(buf+strlen(p), ' ', DIRSIZ-strlen(p));
 4ba:	e8 41 fd ff ff       	call   200 <strlen>
 4bf:	ba 0e 00 00 00       	mov    $0xe,%edx
 4c4:	83 c4 0c             	add    $0xc,%esp
 4c7:	05 c0 10 00 00       	add    $0x10c0,%eax
 4cc:	29 f2                	sub    %esi,%edx
 4ce:	52                   	push   %edx
 4cf:	6a 20                	push   $0x20
 4d1:	50                   	push   %eax
 4d2:	e8 59 fd ff ff       	call   230 <memset>
  return buf;
 4d7:	83 c4 10             	add    $0x10,%esp
}
 4da:	8d 65 f8             	lea    -0x8(%ebp),%esp
 4dd:	89 d8                	mov    %ebx,%eax
 4df:	5b                   	pop    %ebx
 4e0:	5e                   	pop    %esi
 4e1:	5d                   	pop    %ebp
 4e2:	c3                   	ret    
 4e3:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
 4e9:	8d bc 27 00 00 00 00 	lea    0x0(%edi,%eiz,1),%edi

000004f0 <ls>:

void
ls(char *path)
{
 4f0:	55                   	push   %ebp
 4f1:	89 e5                	mov    %esp,%ebp
 4f3:	57                   	push   %edi
 4f4:	56                   	push   %esi
 4f5:	53                   	push   %ebx
 4f6:	81 ec 5c 02 00 00    	sub    $0x25c,%esp

  int cid = getcid();
 4fc:	e8 6d 03 00 00       	call   86e <getcid>

  printf(2, "Cid is: %d\n", cid);
 501:	83 ec 04             	sub    $0x4,%esp
  int cid = getcid();
 504:	89 c7                	mov    %eax,%edi
  printf(2, "Cid is: %d\n", cid);
 506:	50                   	push   %eax
 507:	68 af 0c 00 00       	push   $0xcaf
 50c:	6a 02                	push   $0x2
 50e:	e8 0d 04 00 00       	call   920 <printf>
  char buf[512], *p;
  int fd;
  struct dirent de;
  struct stat st;
  if((fd = open(path, 0)) < 0){
 513:	59                   	pop    %ecx
 514:	5b                   	pop    %ebx
 515:	6a 00                	push   $0x0
 517:	ff 75 08             	pushl  0x8(%ebp)
 51a:	e8 a7 02 00 00       	call   7c6 <open>
 51f:	83 c4 10             	add    $0x10,%esp
 522:	85 c0                	test   %eax,%eax
 524:	78 5a                	js     580 <ls+0x90>
    printf(2, "ls: cannot open %s\n", path);
    return;
  }

  if(fstat(fd, &st) < 0){
 526:	8d b5 d0 fd ff ff    	lea    -0x230(%ebp),%esi
 52c:	83 ec 08             	sub    $0x8,%esp
 52f:	89 c3                	mov    %eax,%ebx
 531:	56                   	push   %esi
 532:	50                   	push   %eax
 533:	e8 a6 02 00 00       	call   7de <fstat>
 538:	83 c4 10             	add    $0x10,%esp
 53b:	85 c0                	test   %eax,%eax
 53d:	0f 88 cd 00 00 00    	js     610 <ls+0x120>
    printf(2, "ls: cannot stat %s\n", path);
    close(fd);
    return;
  }
  switch(st.type){
 543:	0f b7 85 d0 fd ff ff 	movzwl -0x230(%ebp),%eax
 54a:	66 83 f8 01          	cmp    $0x1,%ax
 54e:	74 50                	je     5a0 <ls+0xb0>
 550:	66 83 f8 02          	cmp    $0x2,%ax
 554:	75 12                	jne    568 <ls+0x78>
  case T_FILE:
    if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 556:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 55c:	8d 42 01             	lea    0x1(%edx),%eax
 55f:	83 f8 01             	cmp    $0x1,%eax
 562:	76 6c                	jbe    5d0 <ls+0xe0>
 564:	39 fa                	cmp    %edi,%edx
 566:	74 68                	je     5d0 <ls+0xe0>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
    }
    break;
  }
  close(fd);
 568:	83 ec 0c             	sub    $0xc,%esp
 56b:	53                   	push   %ebx
 56c:	e8 3d 02 00 00       	call   7ae <close>
 571:	83 c4 10             	add    $0x10,%esp

}
 574:	8d 65 f4             	lea    -0xc(%ebp),%esp
 577:	5b                   	pop    %ebx
 578:	5e                   	pop    %esi
 579:	5f                   	pop    %edi
 57a:	5d                   	pop    %ebp
 57b:	c3                   	ret    
 57c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    printf(2, "ls: cannot open %s\n", path);
 580:	83 ec 04             	sub    $0x4,%esp
 583:	ff 75 08             	pushl  0x8(%ebp)
 586:	68 bb 0c 00 00       	push   $0xcbb
 58b:	6a 02                	push   $0x2
 58d:	e8 8e 03 00 00       	call   920 <printf>
    return;
 592:	83 c4 10             	add    $0x10,%esp
}
 595:	8d 65 f4             	lea    -0xc(%ebp),%esp
 598:	5b                   	pop    %ebx
 599:	5e                   	pop    %esi
 59a:	5f                   	pop    %edi
 59b:	5d                   	pop    %ebp
 59c:	c3                   	ret    
 59d:	8d 76 00             	lea    0x0(%esi),%esi
    if(strlen(path) + 1 + DIRSIZ + 1 > sizeof buf){
 5a0:	83 ec 0c             	sub    $0xc,%esp
 5a3:	ff 75 08             	pushl  0x8(%ebp)
 5a6:	e8 55 fc ff ff       	call   200 <strlen>
 5ab:	83 c0 10             	add    $0x10,%eax
 5ae:	83 c4 10             	add    $0x10,%esp
 5b1:	3d 00 02 00 00       	cmp    $0x200,%eax
 5b6:	0f 86 7c 00 00 00    	jbe    638 <ls+0x148>
      printf(1, "ls: path too long\n");
 5bc:	83 ec 08             	sub    $0x8,%esp
 5bf:	68 f3 0c 00 00       	push   $0xcf3
 5c4:	6a 01                	push   $0x1
 5c6:	e8 55 03 00 00       	call   920 <printf>
      break;
 5cb:	83 c4 10             	add    $0x10,%esp
 5ce:	eb 98                	jmp    568 <ls+0x78>
    printf(1, "%s %d %d %d %d\n", fmtname(path), st.type, st.ino, st.size, st.cid);
 5d0:	83 ec 0c             	sub    $0xc,%esp
 5d3:	ff 75 08             	pushl  0x8(%ebp)
 5d6:	89 95 b4 fd ff ff    	mov    %edx,-0x24c(%ebp)
 5dc:	8b bd e0 fd ff ff    	mov    -0x220(%ebp),%edi
 5e2:	8b b5 d8 fd ff ff    	mov    -0x228(%ebp),%esi
 5e8:	e8 63 fe ff ff       	call   450 <fmtname>
 5ed:	8b 95 b4 fd ff ff    	mov    -0x24c(%ebp),%edx
 5f3:	83 c4 0c             	add    $0xc,%esp
 5f6:	52                   	push   %edx
 5f7:	57                   	push   %edi
 5f8:	56                   	push   %esi
 5f9:	6a 02                	push   $0x2
 5fb:	50                   	push   %eax
 5fc:	68 e3 0c 00 00       	push   $0xce3
 601:	6a 01                	push   $0x1
 603:	e8 18 03 00 00       	call   920 <printf>
    break;
 608:	83 c4 20             	add    $0x20,%esp
 60b:	e9 58 ff ff ff       	jmp    568 <ls+0x78>
    printf(2, "ls: cannot stat %s\n", path);
 610:	83 ec 04             	sub    $0x4,%esp
 613:	ff 75 08             	pushl  0x8(%ebp)
 616:	68 cf 0c 00 00       	push   $0xccf
 61b:	6a 02                	push   $0x2
 61d:	e8 fe 02 00 00       	call   920 <printf>
    close(fd);
 622:	89 1c 24             	mov    %ebx,(%esp)
 625:	e8 84 01 00 00       	call   7ae <close>
    return;
 62a:	83 c4 10             	add    $0x10,%esp
}
 62d:	8d 65 f4             	lea    -0xc(%ebp),%esp
 630:	5b                   	pop    %ebx
 631:	5e                   	pop    %esi
 632:	5f                   	pop    %edi
 633:	5d                   	pop    %ebp
 634:	c3                   	ret    
 635:	8d 76 00             	lea    0x0(%esi),%esi
    strcpy(buf, path);
 638:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 63e:	83 ec 08             	sub    $0x8,%esp
 641:	ff 75 08             	pushl  0x8(%ebp)
 644:	50                   	push   %eax
 645:	e8 36 fb ff ff       	call   180 <strcpy>
    p = buf+strlen(buf);
 64a:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 650:	89 04 24             	mov    %eax,(%esp)
 653:	e8 a8 fb ff ff       	call   200 <strlen>
 658:	8d 8d e8 fd ff ff    	lea    -0x218(%ebp),%ecx
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 65e:	83 c4 10             	add    $0x10,%esp
    p = buf+strlen(buf);
 661:	01 c8                	add    %ecx,%eax
    *p++ = '/';
 663:	8d 48 01             	lea    0x1(%eax),%ecx
    p = buf+strlen(buf);
 666:	89 85 b4 fd ff ff    	mov    %eax,-0x24c(%ebp)
    *p++ = '/';
 66c:	c6 00 2f             	movb   $0x2f,(%eax)
 66f:	89 8d b0 fd ff ff    	mov    %ecx,-0x250(%ebp)
 675:	8d 76 00             	lea    0x0(%esi),%esi
    while(read(fd, &de, sizeof(de)) == sizeof(de)){
 678:	8d 85 c0 fd ff ff    	lea    -0x240(%ebp),%eax
 67e:	83 ec 04             	sub    $0x4,%esp
 681:	6a 10                	push   $0x10
 683:	50                   	push   %eax
 684:	53                   	push   %ebx
 685:	e8 14 01 00 00       	call   79e <read>
 68a:	83 c4 10             	add    $0x10,%esp
 68d:	83 f8 10             	cmp    $0x10,%eax
 690:	0f 85 d2 fe ff ff    	jne    568 <ls+0x78>
      if(de.inum == 0)
 696:	66 83 bd c0 fd ff ff 	cmpw   $0x0,-0x240(%ebp)
 69d:	00 
 69e:	74 d8                	je     678 <ls+0x188>
      memmove(p, de.name, DIRSIZ);
 6a0:	8d 85 c2 fd ff ff    	lea    -0x23e(%ebp),%eax
 6a6:	83 ec 04             	sub    $0x4,%esp
 6a9:	6a 0e                	push   $0xe
 6ab:	50                   	push   %eax
 6ac:	ff b5 b0 fd ff ff    	pushl  -0x250(%ebp)
 6b2:	e8 e9 fc ff ff       	call   3a0 <memmove>
      p[DIRSIZ] = 0;
 6b7:	8b 85 b4 fd ff ff    	mov    -0x24c(%ebp),%eax
 6bd:	c6 40 0f 00          	movb   $0x0,0xf(%eax)
      if(stat(buf, &st) < 0){
 6c1:	58                   	pop    %eax
 6c2:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 6c8:	5a                   	pop    %edx
 6c9:	56                   	push   %esi
 6ca:	50                   	push   %eax
 6cb:	e8 40 fc ff ff       	call   310 <stat>
 6d0:	83 c4 10             	add    $0x10,%esp
 6d3:	85 c0                	test   %eax,%eax
 6d5:	0f 88 85 00 00 00    	js     760 <ls+0x270>
      if (st.cid ==0 || st.cid==-1 || st.cid == cid){
 6db:	8b 95 e4 fd ff ff    	mov    -0x21c(%ebp),%edx
 6e1:	8d 42 01             	lea    0x1(%edx),%eax
 6e4:	83 f8 01             	cmp    $0x1,%eax
 6e7:	76 04                	jbe    6ed <ls+0x1fd>
 6e9:	39 fa                	cmp    %edi,%edx
 6eb:	75 8b                	jne    678 <ls+0x188>
      printf(1, "%s %d %d %d %d\n", fmtname(buf), st.type, st.ino, st.size, st.cid);}
 6ed:	8b 8d e0 fd ff ff    	mov    -0x220(%ebp),%ecx
 6f3:	89 95 a0 fd ff ff    	mov    %edx,-0x260(%ebp)
 6f9:	8d 95 e8 fd ff ff    	lea    -0x218(%ebp),%edx
 6ff:	83 ec 0c             	sub    $0xc,%esp
 702:	8b 85 d8 fd ff ff    	mov    -0x228(%ebp),%eax
 708:	52                   	push   %edx
 709:	89 8d a4 fd ff ff    	mov    %ecx,-0x25c(%ebp)
 70f:	0f bf 8d d0 fd ff ff 	movswl -0x230(%ebp),%ecx
 716:	89 85 ac fd ff ff    	mov    %eax,-0x254(%ebp)
 71c:	89 8d a8 fd ff ff    	mov    %ecx,-0x258(%ebp)
 722:	e8 29 fd ff ff       	call   450 <fmtname>
 727:	8b 95 a0 fd ff ff    	mov    -0x260(%ebp),%edx
 72d:	8b 8d a4 fd ff ff    	mov    -0x25c(%ebp),%ecx
 733:	83 c4 0c             	add    $0xc,%esp
 736:	52                   	push   %edx
 737:	51                   	push   %ecx
 738:	ff b5 ac fd ff ff    	pushl  -0x254(%ebp)
 73e:	ff b5 a8 fd ff ff    	pushl  -0x258(%ebp)
 744:	50                   	push   %eax
 745:	68 e3 0c 00 00       	push   $0xce3
 74a:	6a 01                	push   $0x1
 74c:	e8 cf 01 00 00       	call   920 <printf>
 751:	83 c4 20             	add    $0x20,%esp
 754:	e9 1f ff ff ff       	jmp    678 <ls+0x188>
 759:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        printf(1, "ls: cannot stat %s\n", buf);
 760:	8d 85 e8 fd ff ff    	lea    -0x218(%ebp),%eax
 766:	83 ec 04             	sub    $0x4,%esp
 769:	50                   	push   %eax
 76a:	68 cf 0c 00 00       	push   $0xccf
 76f:	6a 01                	push   $0x1
 771:	e8 aa 01 00 00       	call   920 <printf>
        continue;
 776:	83 c4 10             	add    $0x10,%esp
 779:	e9 fa fe ff ff       	jmp    678 <ls+0x188>

0000077e <fork>:
  name: \
    movl $SYS_ ## name, %eax; \
    int $T_SYSCALL; \
    ret

SYSCALL(fork)
 77e:	b8 01 00 00 00       	mov    $0x1,%eax
 783:	cd 40                	int    $0x40
 785:	c3                   	ret    

00000786 <exit>:
SYSCALL(exit)
 786:	b8 02 00 00 00       	mov    $0x2,%eax
 78b:	cd 40                	int    $0x40
 78d:	c3                   	ret    

0000078e <wait>:
SYSCALL(wait)
 78e:	b8 03 00 00 00       	mov    $0x3,%eax
 793:	cd 40                	int    $0x40
 795:	c3                   	ret    

00000796 <pipe>:
SYSCALL(pipe)
 796:	b8 04 00 00 00       	mov    $0x4,%eax
 79b:	cd 40                	int    $0x40
 79d:	c3                   	ret    

0000079e <read>:
SYSCALL(read)
 79e:	b8 05 00 00 00       	mov    $0x5,%eax
 7a3:	cd 40                	int    $0x40
 7a5:	c3                   	ret    

000007a6 <write>:
SYSCALL(write)
 7a6:	b8 10 00 00 00       	mov    $0x10,%eax
 7ab:	cd 40                	int    $0x40
 7ad:	c3                   	ret    

000007ae <close>:
SYSCALL(close)
 7ae:	b8 15 00 00 00       	mov    $0x15,%eax
 7b3:	cd 40                	int    $0x40
 7b5:	c3                   	ret    

000007b6 <kill>:
SYSCALL(kill)
 7b6:	b8 06 00 00 00       	mov    $0x6,%eax
 7bb:	cd 40                	int    $0x40
 7bd:	c3                   	ret    

000007be <exec>:
SYSCALL(exec)
 7be:	b8 07 00 00 00       	mov    $0x7,%eax
 7c3:	cd 40                	int    $0x40
 7c5:	c3                   	ret    

000007c6 <open>:
SYSCALL(open)
 7c6:	b8 0f 00 00 00       	mov    $0xf,%eax
 7cb:	cd 40                	int    $0x40
 7cd:	c3                   	ret    

000007ce <mknod>:
SYSCALL(mknod)
 7ce:	b8 11 00 00 00       	mov    $0x11,%eax
 7d3:	cd 40                	int    $0x40
 7d5:	c3                   	ret    

000007d6 <unlink>:
SYSCALL(unlink)
 7d6:	b8 12 00 00 00       	mov    $0x12,%eax
 7db:	cd 40                	int    $0x40
 7dd:	c3                   	ret    

000007de <fstat>:
SYSCALL(fstat)
 7de:	b8 08 00 00 00       	mov    $0x8,%eax
 7e3:	cd 40                	int    $0x40
 7e5:	c3                   	ret    

000007e6 <link>:
SYSCALL(link)
 7e6:	b8 13 00 00 00       	mov    $0x13,%eax
 7eb:	cd 40                	int    $0x40
 7ed:	c3                   	ret    

000007ee <mkdir>:
SYSCALL(mkdir)
 7ee:	b8 14 00 00 00       	mov    $0x14,%eax
 7f3:	cd 40                	int    $0x40
 7f5:	c3                   	ret    

000007f6 <chdir>:
SYSCALL(chdir)
 7f6:	b8 09 00 00 00       	mov    $0x9,%eax
 7fb:	cd 40                	int    $0x40
 7fd:	c3                   	ret    

000007fe <dup>:
SYSCALL(dup)
 7fe:	b8 0a 00 00 00       	mov    $0xa,%eax
 803:	cd 40                	int    $0x40
 805:	c3                   	ret    

00000806 <getpid>:
SYSCALL(getpid)
 806:	b8 0b 00 00 00       	mov    $0xb,%eax
 80b:	cd 40                	int    $0x40
 80d:	c3                   	ret    

0000080e <sbrk>:
SYSCALL(sbrk)
 80e:	b8 0c 00 00 00       	mov    $0xc,%eax
 813:	cd 40                	int    $0x40
 815:	c3                   	ret    

00000816 <sleep>:
SYSCALL(sleep)
 816:	b8 0d 00 00 00       	mov    $0xd,%eax
 81b:	cd 40                	int    $0x40
 81d:	c3                   	ret    

0000081e <uptime>:
SYSCALL(uptime)
 81e:	b8 0e 00 00 00       	mov    $0xe,%eax
 823:	cd 40                	int    $0x40
 825:	c3                   	ret    

00000826 <halt>:
SYSCALL(halt)
 826:	b8 16 00 00 00       	mov    $0x16,%eax
 82b:	cd 40                	int    $0x40
 82d:	c3                   	ret    

0000082e <toggle>:
SYSCALL(toggle)
 82e:	b8 17 00 00 00       	mov    $0x17,%eax
 833:	cd 40                	int    $0x40
 835:	c3                   	ret    

00000836 <ps>:
SYSCALL(ps)
 836:	b8 18 00 00 00       	mov    $0x18,%eax
 83b:	cd 40                	int    $0x40
 83d:	c3                   	ret    

0000083e <create_container>:
SYSCALL(create_container)
 83e:	b8 1c 00 00 00       	mov    $0x1c,%eax
 843:	cd 40                	int    $0x40
 845:	c3                   	ret    

00000846 <destroy_container>:
SYSCALL(destroy_container)
 846:	b8 19 00 00 00       	mov    $0x19,%eax
 84b:	cd 40                	int    $0x40
 84d:	c3                   	ret    

0000084e <join_container>:
SYSCALL(join_container)
 84e:	b8 1a 00 00 00       	mov    $0x1a,%eax
 853:	cd 40                	int    $0x40
 855:	c3                   	ret    

00000856 <leave_container>:
SYSCALL(leave_container)
 856:	b8 1b 00 00 00       	mov    $0x1b,%eax
 85b:	cd 40                	int    $0x40
 85d:	c3                   	ret    

0000085e <send>:
SYSCALL(send)
 85e:	b8 1d 00 00 00       	mov    $0x1d,%eax
 863:	cd 40                	int    $0x40
 865:	c3                   	ret    

00000866 <recv>:
SYSCALL(recv)
 866:	b8 1e 00 00 00       	mov    $0x1e,%eax
 86b:	cd 40                	int    $0x40
 86d:	c3                   	ret    

0000086e <getcid>:
SYSCALL(getcid)
 86e:	b8 1f 00 00 00       	mov    $0x1f,%eax
 873:	cd 40                	int    $0x40
 875:	c3                   	ret    
 876:	66 90                	xchg   %ax,%ax
 878:	66 90                	xchg   %ax,%ax
 87a:	66 90                	xchg   %ax,%ax
 87c:	66 90                	xchg   %ax,%ax
 87e:	66 90                	xchg   %ax,%ax

00000880 <printint>:
  write(fd, &c, 1);
}

static void
printint(int fd, int xx, int base, int sgn)
{
 880:	55                   	push   %ebp
 881:	89 e5                	mov    %esp,%ebp
 883:	57                   	push   %edi
 884:	56                   	push   %esi
 885:	53                   	push   %ebx
 886:	83 ec 3c             	sub    $0x3c,%esp
  char buf[16];
  int i, neg;
  uint x;

  neg = 0;
  if(sgn && xx < 0){
 889:	85 d2                	test   %edx,%edx
{
 88b:	89 45 c0             	mov    %eax,-0x40(%ebp)
    neg = 1;
    x = -xx;
 88e:	89 d0                	mov    %edx,%eax
  if(sgn && xx < 0){
 890:	79 76                	jns    908 <printint+0x88>
 892:	f6 45 08 01          	testb  $0x1,0x8(%ebp)
 896:	74 70                	je     908 <printint+0x88>
    x = -xx;
 898:	f7 d8                	neg    %eax
    neg = 1;
 89a:	c7 45 c4 01 00 00 00 	movl   $0x1,-0x3c(%ebp)
  } else {
    x = xx;
  }

  i = 0;
 8a1:	31 f6                	xor    %esi,%esi
 8a3:	8d 5d d7             	lea    -0x29(%ebp),%ebx
 8a6:	eb 0a                	jmp    8b2 <printint+0x32>
 8a8:	90                   	nop
 8a9:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  do{
    buf[i++] = digits[x % base];
 8b0:	89 fe                	mov    %edi,%esi
 8b2:	31 d2                	xor    %edx,%edx
 8b4:	8d 7e 01             	lea    0x1(%esi),%edi
 8b7:	f7 f1                	div    %ecx
 8b9:	0f b6 92 10 0d 00 00 	movzbl 0xd10(%edx),%edx
  }while((x /= base) != 0);
 8c0:	85 c0                	test   %eax,%eax
    buf[i++] = digits[x % base];
 8c2:	88 14 3b             	mov    %dl,(%ebx,%edi,1)
  }while((x /= base) != 0);
 8c5:	75 e9                	jne    8b0 <printint+0x30>
  if(neg)
 8c7:	8b 45 c4             	mov    -0x3c(%ebp),%eax
 8ca:	85 c0                	test   %eax,%eax
 8cc:	74 08                	je     8d6 <printint+0x56>
    buf[i++] = '-';
 8ce:	c6 44 3d d8 2d       	movb   $0x2d,-0x28(%ebp,%edi,1)
 8d3:	8d 7e 02             	lea    0x2(%esi),%edi
 8d6:	8d 74 3d d7          	lea    -0x29(%ebp,%edi,1),%esi
 8da:	8b 7d c0             	mov    -0x40(%ebp),%edi
 8dd:	8d 76 00             	lea    0x0(%esi),%esi
 8e0:	0f b6 06             	movzbl (%esi),%eax
  write(fd, &c, 1);
 8e3:	83 ec 04             	sub    $0x4,%esp
 8e6:	83 ee 01             	sub    $0x1,%esi
 8e9:	6a 01                	push   $0x1
 8eb:	53                   	push   %ebx
 8ec:	57                   	push   %edi
 8ed:	88 45 d7             	mov    %al,-0x29(%ebp)
 8f0:	e8 b1 fe ff ff       	call   7a6 <write>

  while(--i >= 0)
 8f5:	83 c4 10             	add    $0x10,%esp
 8f8:	39 de                	cmp    %ebx,%esi
 8fa:	75 e4                	jne    8e0 <printint+0x60>
    putc(fd, buf[i]);
}
 8fc:	8d 65 f4             	lea    -0xc(%ebp),%esp
 8ff:	5b                   	pop    %ebx
 900:	5e                   	pop    %esi
 901:	5f                   	pop    %edi
 902:	5d                   	pop    %ebp
 903:	c3                   	ret    
 904:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  neg = 0;
 908:	c7 45 c4 00 00 00 00 	movl   $0x0,-0x3c(%ebp)
 90f:	eb 90                	jmp    8a1 <printint+0x21>
 911:	eb 0d                	jmp    920 <printf>
 913:	90                   	nop
 914:	90                   	nop
 915:	90                   	nop
 916:	90                   	nop
 917:	90                   	nop
 918:	90                   	nop
 919:	90                   	nop
 91a:	90                   	nop
 91b:	90                   	nop
 91c:	90                   	nop
 91d:	90                   	nop
 91e:	90                   	nop
 91f:	90                   	nop

00000920 <printf>:

// Print to the given fd. Only understands %d, %x, %p, %s.
void
printf(int fd, const char *fmt, ...)
{
 920:	55                   	push   %ebp
 921:	89 e5                	mov    %esp,%ebp
 923:	57                   	push   %edi
 924:	56                   	push   %esi
 925:	53                   	push   %ebx
 926:	83 ec 2c             	sub    $0x2c,%esp
  int c, i, state;
  uint *ap;

  state = 0;
  ap = (uint*)(void*)&fmt + 1;
  for(i = 0; fmt[i]; i++){
 929:	8b 75 0c             	mov    0xc(%ebp),%esi
 92c:	0f b6 1e             	movzbl (%esi),%ebx
 92f:	84 db                	test   %bl,%bl
 931:	0f 84 b3 00 00 00    	je     9ea <printf+0xca>
  ap = (uint*)(void*)&fmt + 1;
 937:	8d 45 10             	lea    0x10(%ebp),%eax
 93a:	83 c6 01             	add    $0x1,%esi
  state = 0;
 93d:	31 ff                	xor    %edi,%edi
  ap = (uint*)(void*)&fmt + 1;
 93f:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 942:	eb 2f                	jmp    973 <printf+0x53>
 944:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    c = fmt[i] & 0xff;
    if(state == 0){
      if(c == '%'){
 948:	83 f8 25             	cmp    $0x25,%eax
 94b:	0f 84 a7 00 00 00    	je     9f8 <printf+0xd8>
  write(fd, &c, 1);
 951:	8d 45 e2             	lea    -0x1e(%ebp),%eax
 954:	83 ec 04             	sub    $0x4,%esp
 957:	88 5d e2             	mov    %bl,-0x1e(%ebp)
 95a:	6a 01                	push   $0x1
 95c:	50                   	push   %eax
 95d:	ff 75 08             	pushl  0x8(%ebp)
 960:	e8 41 fe ff ff       	call   7a6 <write>
 965:	83 c4 10             	add    $0x10,%esp
 968:	83 c6 01             	add    $0x1,%esi
  for(i = 0; fmt[i]; i++){
 96b:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
 96f:	84 db                	test   %bl,%bl
 971:	74 77                	je     9ea <printf+0xca>
    if(state == 0){
 973:	85 ff                	test   %edi,%edi
    c = fmt[i] & 0xff;
 975:	0f be cb             	movsbl %bl,%ecx
 978:	0f b6 c3             	movzbl %bl,%eax
    if(state == 0){
 97b:	74 cb                	je     948 <printf+0x28>
        state = '%';
      } else {
        putc(fd, c);
      }
    } else if(state == '%'){
 97d:	83 ff 25             	cmp    $0x25,%edi
 980:	75 e6                	jne    968 <printf+0x48>
      if(c == 'd'){
 982:	83 f8 64             	cmp    $0x64,%eax
 985:	0f 84 05 01 00 00    	je     a90 <printf+0x170>
        printint(fd, *ap, 10, 1);
        ap++;
      } else if(c == 'x' || c == 'p'){
 98b:	81 e1 f7 00 00 00    	and    $0xf7,%ecx
 991:	83 f9 70             	cmp    $0x70,%ecx
 994:	74 72                	je     a08 <printf+0xe8>
        printint(fd, *ap, 16, 0);
        ap++;
      } else if(c == 's'){
 996:	83 f8 73             	cmp    $0x73,%eax
 999:	0f 84 99 00 00 00    	je     a38 <printf+0x118>
          s = "(null)";
        while(*s != 0){
          putc(fd, *s);
          s++;
        }
      } else if(c == 'c'){
 99f:	83 f8 63             	cmp    $0x63,%eax
 9a2:	0f 84 08 01 00 00    	je     ab0 <printf+0x190>
        putc(fd, *ap);
        ap++;
      } else if(c == '%'){
 9a8:	83 f8 25             	cmp    $0x25,%eax
 9ab:	0f 84 ef 00 00 00    	je     aa0 <printf+0x180>
  write(fd, &c, 1);
 9b1:	8d 45 e7             	lea    -0x19(%ebp),%eax
 9b4:	83 ec 04             	sub    $0x4,%esp
 9b7:	c6 45 e7 25          	movb   $0x25,-0x19(%ebp)
 9bb:	6a 01                	push   $0x1
 9bd:	50                   	push   %eax
 9be:	ff 75 08             	pushl  0x8(%ebp)
 9c1:	e8 e0 fd ff ff       	call   7a6 <write>
 9c6:	83 c4 0c             	add    $0xc,%esp
 9c9:	8d 45 e6             	lea    -0x1a(%ebp),%eax
 9cc:	88 5d e6             	mov    %bl,-0x1a(%ebp)
 9cf:	6a 01                	push   $0x1
 9d1:	50                   	push   %eax
 9d2:	ff 75 08             	pushl  0x8(%ebp)
 9d5:	83 c6 01             	add    $0x1,%esi
      } else {
        // Unknown % sequence.  Print it to draw attention.
        putc(fd, '%');
        putc(fd, c);
      }
      state = 0;
 9d8:	31 ff                	xor    %edi,%edi
  write(fd, &c, 1);
 9da:	e8 c7 fd ff ff       	call   7a6 <write>
  for(i = 0; fmt[i]; i++){
 9df:	0f b6 5e ff          	movzbl -0x1(%esi),%ebx
  write(fd, &c, 1);
 9e3:	83 c4 10             	add    $0x10,%esp
  for(i = 0; fmt[i]; i++){
 9e6:	84 db                	test   %bl,%bl
 9e8:	75 89                	jne    973 <printf+0x53>
    }
  }
}
 9ea:	8d 65 f4             	lea    -0xc(%ebp),%esp
 9ed:	5b                   	pop    %ebx
 9ee:	5e                   	pop    %esi
 9ef:	5f                   	pop    %edi
 9f0:	5d                   	pop    %ebp
 9f1:	c3                   	ret    
 9f2:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        state = '%';
 9f8:	bf 25 00 00 00       	mov    $0x25,%edi
 9fd:	e9 66 ff ff ff       	jmp    968 <printf+0x48>
 a02:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
        printint(fd, *ap, 16, 0);
 a08:	83 ec 0c             	sub    $0xc,%esp
 a0b:	b9 10 00 00 00       	mov    $0x10,%ecx
 a10:	6a 00                	push   $0x0
 a12:	8b 7d d4             	mov    -0x2c(%ebp),%edi
 a15:	8b 45 08             	mov    0x8(%ebp),%eax
 a18:	8b 17                	mov    (%edi),%edx
 a1a:	e8 61 fe ff ff       	call   880 <printint>
        ap++;
 a1f:	89 f8                	mov    %edi,%eax
 a21:	83 c4 10             	add    $0x10,%esp
      state = 0;
 a24:	31 ff                	xor    %edi,%edi
        ap++;
 a26:	83 c0 04             	add    $0x4,%eax
 a29:	89 45 d4             	mov    %eax,-0x2c(%ebp)
 a2c:	e9 37 ff ff ff       	jmp    968 <printf+0x48>
 a31:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        s = (char*)*ap;
 a38:	8b 45 d4             	mov    -0x2c(%ebp),%eax
 a3b:	8b 08                	mov    (%eax),%ecx
        ap++;
 a3d:	83 c0 04             	add    $0x4,%eax
 a40:	89 45 d4             	mov    %eax,-0x2c(%ebp)
        if(s == 0)
 a43:	85 c9                	test   %ecx,%ecx
 a45:	0f 84 8e 00 00 00    	je     ad9 <printf+0x1b9>
        while(*s != 0){
 a4b:	0f b6 01             	movzbl (%ecx),%eax
      state = 0;
 a4e:	31 ff                	xor    %edi,%edi
        s = (char*)*ap;
 a50:	89 cb                	mov    %ecx,%ebx
        while(*s != 0){
 a52:	84 c0                	test   %al,%al
 a54:	0f 84 0e ff ff ff    	je     968 <printf+0x48>
 a5a:	89 75 d0             	mov    %esi,-0x30(%ebp)
 a5d:	89 de                	mov    %ebx,%esi
 a5f:	8b 5d 08             	mov    0x8(%ebp),%ebx
 a62:	8d 7d e3             	lea    -0x1d(%ebp),%edi
 a65:	8d 76 00             	lea    0x0(%esi),%esi
  write(fd, &c, 1);
 a68:	83 ec 04             	sub    $0x4,%esp
          s++;
 a6b:	83 c6 01             	add    $0x1,%esi
 a6e:	88 45 e3             	mov    %al,-0x1d(%ebp)
  write(fd, &c, 1);
 a71:	6a 01                	push   $0x1
 a73:	57                   	push   %edi
 a74:	53                   	push   %ebx
 a75:	e8 2c fd ff ff       	call   7a6 <write>
        while(*s != 0){
 a7a:	0f b6 06             	movzbl (%esi),%eax
 a7d:	83 c4 10             	add    $0x10,%esp
 a80:	84 c0                	test   %al,%al
 a82:	75 e4                	jne    a68 <printf+0x148>
 a84:	8b 75 d0             	mov    -0x30(%ebp),%esi
      state = 0;
 a87:	31 ff                	xor    %edi,%edi
 a89:	e9 da fe ff ff       	jmp    968 <printf+0x48>
 a8e:	66 90                	xchg   %ax,%ax
        printint(fd, *ap, 10, 1);
 a90:	83 ec 0c             	sub    $0xc,%esp
 a93:	b9 0a 00 00 00       	mov    $0xa,%ecx
 a98:	6a 01                	push   $0x1
 a9a:	e9 73 ff ff ff       	jmp    a12 <printf+0xf2>
 a9f:	90                   	nop
  write(fd, &c, 1);
 aa0:	83 ec 04             	sub    $0x4,%esp
 aa3:	88 5d e5             	mov    %bl,-0x1b(%ebp)
 aa6:	8d 45 e5             	lea    -0x1b(%ebp),%eax
 aa9:	6a 01                	push   $0x1
 aab:	e9 21 ff ff ff       	jmp    9d1 <printf+0xb1>
        putc(fd, *ap);
 ab0:	8b 7d d4             	mov    -0x2c(%ebp),%edi
  write(fd, &c, 1);
 ab3:	83 ec 04             	sub    $0x4,%esp
        putc(fd, *ap);
 ab6:	8b 07                	mov    (%edi),%eax
  write(fd, &c, 1);
 ab8:	6a 01                	push   $0x1
        ap++;
 aba:	83 c7 04             	add    $0x4,%edi
        putc(fd, *ap);
 abd:	88 45 e4             	mov    %al,-0x1c(%ebp)
  write(fd, &c, 1);
 ac0:	8d 45 e4             	lea    -0x1c(%ebp),%eax
 ac3:	50                   	push   %eax
 ac4:	ff 75 08             	pushl  0x8(%ebp)
 ac7:	e8 da fc ff ff       	call   7a6 <write>
        ap++;
 acc:	89 7d d4             	mov    %edi,-0x2c(%ebp)
 acf:	83 c4 10             	add    $0x10,%esp
      state = 0;
 ad2:	31 ff                	xor    %edi,%edi
 ad4:	e9 8f fe ff ff       	jmp    968 <printf+0x48>
          s = "(null)";
 ad9:	bb 06 0d 00 00       	mov    $0xd06,%ebx
        while(*s != 0){
 ade:	b8 28 00 00 00       	mov    $0x28,%eax
 ae3:	e9 72 ff ff ff       	jmp    a5a <printf+0x13a>
 ae8:	66 90                	xchg   %ax,%ax
 aea:	66 90                	xchg   %ax,%ax
 aec:	66 90                	xchg   %ax,%ax
 aee:	66 90                	xchg   %ax,%ax

00000af0 <free>:
static Header base;
static Header *freep;

void
free(void *ap)
{
 af0:	55                   	push   %ebp
  Header *bp, *p;

  bp = (Header*)ap - 1;
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 af1:	a1 d0 10 00 00       	mov    0x10d0,%eax
{
 af6:	89 e5                	mov    %esp,%ebp
 af8:	57                   	push   %edi
 af9:	56                   	push   %esi
 afa:	53                   	push   %ebx
 afb:	8b 5d 08             	mov    0x8(%ebp),%ebx
  bp = (Header*)ap - 1;
 afe:	8d 4b f8             	lea    -0x8(%ebx),%ecx
 b01:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
  for(p = freep; !(bp > p && bp < p->s.ptr); p = p->s.ptr)
 b08:	39 c8                	cmp    %ecx,%eax
 b0a:	8b 10                	mov    (%eax),%edx
 b0c:	73 32                	jae    b40 <free+0x50>
 b0e:	39 d1                	cmp    %edx,%ecx
 b10:	72 04                	jb     b16 <free+0x26>
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b12:	39 d0                	cmp    %edx,%eax
 b14:	72 32                	jb     b48 <free+0x58>
      break;
  if(bp + bp->s.size == p->s.ptr){
 b16:	8b 73 fc             	mov    -0x4(%ebx),%esi
 b19:	8d 3c f1             	lea    (%ecx,%esi,8),%edi
 b1c:	39 fa                	cmp    %edi,%edx
 b1e:	74 30                	je     b50 <free+0x60>
    bp->s.size += p->s.ptr->s.size;
    bp->s.ptr = p->s.ptr->s.ptr;
  } else
    bp->s.ptr = p->s.ptr;
 b20:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b23:	8b 50 04             	mov    0x4(%eax),%edx
 b26:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b29:	39 f1                	cmp    %esi,%ecx
 b2b:	74 3a                	je     b67 <free+0x77>
    p->s.size += bp->s.size;
    p->s.ptr = bp->s.ptr;
  } else
    p->s.ptr = bp;
 b2d:	89 08                	mov    %ecx,(%eax)
  freep = p;
 b2f:	a3 d0 10 00 00       	mov    %eax,0x10d0
}
 b34:	5b                   	pop    %ebx
 b35:	5e                   	pop    %esi
 b36:	5f                   	pop    %edi
 b37:	5d                   	pop    %ebp
 b38:	c3                   	ret    
 b39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    if(p >= p->s.ptr && (bp > p || bp < p->s.ptr))
 b40:	39 d0                	cmp    %edx,%eax
 b42:	72 04                	jb     b48 <free+0x58>
 b44:	39 d1                	cmp    %edx,%ecx
 b46:	72 ce                	jb     b16 <free+0x26>
{
 b48:	89 d0                	mov    %edx,%eax
 b4a:	eb bc                	jmp    b08 <free+0x18>
 b4c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
    bp->s.size += p->s.ptr->s.size;
 b50:	03 72 04             	add    0x4(%edx),%esi
 b53:	89 73 fc             	mov    %esi,-0x4(%ebx)
    bp->s.ptr = p->s.ptr->s.ptr;
 b56:	8b 10                	mov    (%eax),%edx
 b58:	8b 12                	mov    (%edx),%edx
 b5a:	89 53 f8             	mov    %edx,-0x8(%ebx)
  if(p + p->s.size == bp){
 b5d:	8b 50 04             	mov    0x4(%eax),%edx
 b60:	8d 34 d0             	lea    (%eax,%edx,8),%esi
 b63:	39 f1                	cmp    %esi,%ecx
 b65:	75 c6                	jne    b2d <free+0x3d>
    p->s.size += bp->s.size;
 b67:	03 53 fc             	add    -0x4(%ebx),%edx
  freep = p;
 b6a:	a3 d0 10 00 00       	mov    %eax,0x10d0
    p->s.size += bp->s.size;
 b6f:	89 50 04             	mov    %edx,0x4(%eax)
    p->s.ptr = bp->s.ptr;
 b72:	8b 53 f8             	mov    -0x8(%ebx),%edx
 b75:	89 10                	mov    %edx,(%eax)
}
 b77:	5b                   	pop    %ebx
 b78:	5e                   	pop    %esi
 b79:	5f                   	pop    %edi
 b7a:	5d                   	pop    %ebp
 b7b:	c3                   	ret    
 b7c:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi

00000b80 <malloc>:
  return freep;
}

void*
malloc(uint nbytes)
{
 b80:	55                   	push   %ebp
 b81:	89 e5                	mov    %esp,%ebp
 b83:	57                   	push   %edi
 b84:	56                   	push   %esi
 b85:	53                   	push   %ebx
 b86:	83 ec 0c             	sub    $0xc,%esp
  Header *p, *prevp;
  uint nunits;

  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b89:	8b 45 08             	mov    0x8(%ebp),%eax
  if((prevp = freep) == 0){
 b8c:	8b 15 d0 10 00 00    	mov    0x10d0,%edx
  nunits = (nbytes + sizeof(Header) - 1)/sizeof(Header) + 1;
 b92:	8d 78 07             	lea    0x7(%eax),%edi
 b95:	c1 ef 03             	shr    $0x3,%edi
 b98:	83 c7 01             	add    $0x1,%edi
  if((prevp = freep) == 0){
 b9b:	85 d2                	test   %edx,%edx
 b9d:	0f 84 9d 00 00 00    	je     c40 <malloc+0xc0>
 ba3:	8b 02                	mov    (%edx),%eax
 ba5:	8b 48 04             	mov    0x4(%eax),%ecx
    base.s.ptr = freep = prevp = &base;
    base.s.size = 0;
  }
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
    if(p->s.size >= nunits){
 ba8:	39 cf                	cmp    %ecx,%edi
 baa:	76 6c                	jbe    c18 <malloc+0x98>
 bac:	81 ff 00 10 00 00    	cmp    $0x1000,%edi
 bb2:	bb 00 10 00 00       	mov    $0x1000,%ebx
 bb7:	0f 43 df             	cmovae %edi,%ebx
  p = sbrk(nu * sizeof(Header));
 bba:	8d 34 dd 00 00 00 00 	lea    0x0(,%ebx,8),%esi
 bc1:	eb 0e                	jmp    bd1 <malloc+0x51>
 bc3:	90                   	nop
 bc4:	8d 74 26 00          	lea    0x0(%esi,%eiz,1),%esi
  for(p = prevp->s.ptr; ; prevp = p, p = p->s.ptr){
 bc8:	8b 02                	mov    (%edx),%eax
    if(p->s.size >= nunits){
 bca:	8b 48 04             	mov    0x4(%eax),%ecx
 bcd:	39 f9                	cmp    %edi,%ecx
 bcf:	73 47                	jae    c18 <malloc+0x98>
        p->s.size = nunits;
      }
      freep = prevp;
      return (void*)(p + 1);
    }
    if(p == freep)
 bd1:	39 05 d0 10 00 00    	cmp    %eax,0x10d0
 bd7:	89 c2                	mov    %eax,%edx
 bd9:	75 ed                	jne    bc8 <malloc+0x48>
  p = sbrk(nu * sizeof(Header));
 bdb:	83 ec 0c             	sub    $0xc,%esp
 bde:	56                   	push   %esi
 bdf:	e8 2a fc ff ff       	call   80e <sbrk>
  if(p == (char*)-1)
 be4:	83 c4 10             	add    $0x10,%esp
 be7:	83 f8 ff             	cmp    $0xffffffff,%eax
 bea:	74 1c                	je     c08 <malloc+0x88>
  hp->s.size = nu;
 bec:	89 58 04             	mov    %ebx,0x4(%eax)
  free((void*)(hp + 1));
 bef:	83 ec 0c             	sub    $0xc,%esp
 bf2:	83 c0 08             	add    $0x8,%eax
 bf5:	50                   	push   %eax
 bf6:	e8 f5 fe ff ff       	call   af0 <free>
  return freep;
 bfb:	8b 15 d0 10 00 00    	mov    0x10d0,%edx
      if((p = morecore(nunits)) == 0)
 c01:	83 c4 10             	add    $0x10,%esp
 c04:	85 d2                	test   %edx,%edx
 c06:	75 c0                	jne    bc8 <malloc+0x48>
        return 0;
  }
}
 c08:	8d 65 f4             	lea    -0xc(%ebp),%esp
        return 0;
 c0b:	31 c0                	xor    %eax,%eax
}
 c0d:	5b                   	pop    %ebx
 c0e:	5e                   	pop    %esi
 c0f:	5f                   	pop    %edi
 c10:	5d                   	pop    %ebp
 c11:	c3                   	ret    
 c12:	8d b6 00 00 00 00    	lea    0x0(%esi),%esi
      if(p->s.size == nunits)
 c18:	39 cf                	cmp    %ecx,%edi
 c1a:	74 54                	je     c70 <malloc+0xf0>
        p->s.size -= nunits;
 c1c:	29 f9                	sub    %edi,%ecx
 c1e:	89 48 04             	mov    %ecx,0x4(%eax)
        p += p->s.size;
 c21:	8d 04 c8             	lea    (%eax,%ecx,8),%eax
        p->s.size = nunits;
 c24:	89 78 04             	mov    %edi,0x4(%eax)
      freep = prevp;
 c27:	89 15 d0 10 00 00    	mov    %edx,0x10d0
}
 c2d:	8d 65 f4             	lea    -0xc(%ebp),%esp
      return (void*)(p + 1);
 c30:	83 c0 08             	add    $0x8,%eax
}
 c33:	5b                   	pop    %ebx
 c34:	5e                   	pop    %esi
 c35:	5f                   	pop    %edi
 c36:	5d                   	pop    %ebp
 c37:	c3                   	ret    
 c38:	90                   	nop
 c39:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
    base.s.ptr = freep = prevp = &base;
 c40:	c7 05 d0 10 00 00 d4 	movl   $0x10d4,0x10d0
 c47:	10 00 00 
 c4a:	c7 05 d4 10 00 00 d4 	movl   $0x10d4,0x10d4
 c51:	10 00 00 
    base.s.size = 0;
 c54:	b8 d4 10 00 00       	mov    $0x10d4,%eax
 c59:	c7 05 d8 10 00 00 00 	movl   $0x0,0x10d8
 c60:	00 00 00 
 c63:	e9 44 ff ff ff       	jmp    bac <malloc+0x2c>
 c68:	90                   	nop
 c69:	8d b4 26 00 00 00 00 	lea    0x0(%esi,%eiz,1),%esi
        prevp->s.ptr = p->s.ptr;
 c70:	8b 08                	mov    (%eax),%ecx
 c72:	89 0a                	mov    %ecx,(%edx)
 c74:	eb b1                	jmp    c27 <malloc+0xa7>
