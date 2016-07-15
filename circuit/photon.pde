class photon {
  float c = 8;
  float radius = 1;
  PVector old, pos;
  PVector vel;
  color col;
  boolean orbit;
  PVector focus;
  boolean visible = true;
  int countr = 0, countl = 0;
  int countmin = 5;
  boolean oneHit = true;

  photon(PVector pos, PVector dir) {
    this.pos = pos;
    this.old = pos;
    this.vel = dir.normalize().mult(c);
  }

  void update(PApplet a) {
    ++countr; ++countl;
    
    // left 
    if (pos.x < radius) {
      pos.x = radius;
      vel.x *= -1;
      visible = !(visible | oneHit);
    } else
      // right
      if (pos.x > a.width-radius) {
        pos.x = a.width-radius;
        vel.x *= -1;
        visible = !(visible | oneHit);
      }
    // top
    if (pos.y < radius) {
      pos.y = radius;
      vel.y *= -1;
      visible = !(visible | oneHit);
    } else
      // bottom
      if (pos.y > a.height-radius) {
        pos.y = a.height-radius;
        vel.y *= -1;
        visible = !(visible | oneHit);
    }
    
    float rnd = a.random(1);
    //if (rnd > 0.996) visible = !visible;
    
    if (orbit) {
      float a0 = PVector.dot(focus.copy().sub(pos).normalize(),vel)/c;
      
      if (rnd < 0.04 && countl > countmin) {
        vel.rotate(-(float)Math.PI/4);
        countl = 0;
      } else if (a0 < 0 && rnd < 0.6 && countr > countmin) {
        vel.rotate((float)Math.PI/4);
        countr = 0;
      }

    } else {
      if (rnd < 0.04 && countl > countmin) {
        vel.rotate((float)Math.PI/4);
        countl = 0;
      } else if (rnd < 0.08 && countr > countmin) {
        vel.rotate(-(float)Math.PI/4);
        countr = 0;
      }
    }

    old = pos.copy();
    pos.add(vel);
  }

  void draw(PApplet a) {
    if (!visible) return;

    a.stroke(col);
    a.strokeWeight(radius*2);
    a.fill(col);
    a.line(old.x, old.y, pos.x, pos.y);

    a.noStroke();
    a.ellipse(pos.x, pos.y, radius*2, radius*2);
  }
}