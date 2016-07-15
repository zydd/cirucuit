void settings() {
  size(800,600, P2D);
  //fullScreen();
  //noLoop();
}

int n = 20;
ArrayList<photon> p;
photon guide;

void setup() {
  surface.setResizable(true);
  //surface.setFrameRate(1);
  
  guide = new photon(new PVector(random(width), random(height)),
                     new PVector(1,1));
  guide.col = #ffffff;
  guide.vel.mult(1.5);
  guide.radius = 10;

  p = new ArrayList<photon>();

  for (int i = 0; i < n; ++i) {  
    //PVector dir = new PVector(random(1) < 0.5? 1 : -1, random(1) < 0.5? 1 : -1);
    PVector dir = new PVector(1, 0);
    dir.rotate(i * (float)Math.PI/4);
    //photon t = new photon(new PVector(random(width), random(height)), dir);
    photon t = new photon(new PVector(width/2, height/2), dir);
    t.col = #00ffff;
    t.focus = new PVector(width,height);
    t.radius = 1 + random(1);
    t.orbit = false;
    //t.visible = 1 == (i & 1);
    t.focus = guide.pos;
    //t.vel.mult(0.5+random(1));
    p.add(t);
  }

  background(255);
}

void draw() {
  fill(0, 20);
  rect(0, 0, width, height);
  //PVector cent = new PVector(mouseX,mouseY);
  for (int i = 0; i < n; ++i) {
    photon t = p.get(i);
    t.draw(this);
    t.update(this);
  }
  guide.update(this);
  //guide.draw(this);
  //guide.visible = true;

  //saveFrame("frames/####.png");
  if (frameCount % 100 == 0) {
    for (int i = 0; i < n; ++i)
      if (p.get(i).visible)
        return;
    pulse(width/2, height/2);
  }
}

void pulse(int x, int y) {
  for (int i = 0; i < n; ++i) {
    PVector dir = new PVector(1, 0);
    dir.rotate(i * (float)Math.PI/4);

    photon t = p.get(i);
    t.visible = true;
    t.pos.x = x; t.pos.y = y;
    t.old.x = t.pos.x; t.old.y = t.pos.y;
    dir.mult(t.c);
    t.vel = dir;
    t.countr = t.countl = 0;
  }
}

void mouseClicked() {
 pulse(mouseX, mouseY);
}

void keyPressed(KeyEvent e) {  
  switch(e.getKey()) {
    case 'h': case 'H':
      for (int i = 0; i < n; ++i) {
        p.get(i).oneHit = !p.get(i).oneHit;
      }
      break;
    case 'o': case 'O':
      for (int i = 0; i < n; ++i) {
        p.get(i).orbit = !p.get(i).orbit;
      }
      break;
  }
}