/////////////////////////////////////////////////////////////////// File info //
// Fundamentals of Computer Graphics
// > Task 6
// Tomasz Witczak, 216920


//////////////////////////////////////////////////////////// Class: Spaceship //
class Spaceship
{
    //========================================================= Behaviour ====//
    //-------------------------------------------------- Constructors --------//
    Spaceship(final String modelFilename,

              float scaleXYZ,

              float rotationInRadiansX,
              float rotationInRadiansY,
              float rotationInRadiansZ,
              
              float translationX,
              float translationY,
              float translationZ)
    {
        this.model = loadShape(modelFilename);

        this.scaleXYZ = scaleXYZ;

        this.rotationInRadiansX = rotationInRadiansX;
        this.rotationInRadiansY = rotationInRadiansY;
        this.rotationInRadiansZ = rotationInRadiansZ;

        this.translationX = translationX;
        this.translationY = translationY;
        this.translationZ = translationZ;
    }


    //----------------------------------------------------- Rendering --------//
    void render()
    {
        pushMatrix();
        {
            scale(scaleXYZ);
            
            rotateX(rotationInRadiansX);
            rotateY(rotationInRadiansY);
            rotateZ(rotationInRadiansZ);

            translate(translationX, translationY, translationZ);

            shape(model);
        }
        popMatrix();
    }


    //============================================================== Data ====//
    private PShape model;

    float scaleXYZ;

    float rotationInRadiansX;
    float rotationInRadiansY;
    float rotationInRadiansZ;

    float translationX;
    float translationY;
    float translationZ;

}


//////////////////////////////////////////////////////////////// Main program //
void setup()
{
    size(1280, 720, P3D);
    frameRate(framerate);
    noStroke();

    spaceImage = loadImage("space-1280-720.png");

    deer = loadShape("deer.obj");
    capsule = loadShape("capsule.obj");

    colors = new color[12];
    colors[0] = #ff0000;
    colors[1] = #00ff00;
    colors[2] = #0000ff;
    colors[3] = #00ffff;
    colors[4] = #ff00ff;
    colors[5] = #ffff00;
    colors[6] = #ffffff;
    colors[7] = #faafaa;
    colors[8] = #efb0f0;
    colors[9] = #122ac4;
    colors[10] = #642385;
    colors[11] = #ac642c;
    
    sun = new CelestialBody(100, #ffee00, 25, 0, 0);
    planets = new CelestialBody[4];
    planets[0] = new CelestialBody(100, colors[0], 18, TWO_PI / 8, 0);
    planets[1] = new CelestialBody(100, colors[1], 0.06, TWO_PI / 10, 2);
    planets[2] = new CelestialBody(100, colors[2], 20, TWO_PI / 12, 3);
    planets[3] = new CelestialBody(100, colors[3], 16, TWO_PI / 14, 1);
    moons = new CelestialBody[7];
    moons[0] = new CelestialBody(5, colors[4], 8, TWO_PI / 1.5, 0);
    moons[1] = new CelestialBody(6, colors[5], 6, TWO_PI / 4.2, 0);
    moons[2] = new CelestialBody(4, colors[6], 12, TWO_PI / 2.4, 1);
    moons[3] = new CelestialBody(8, colors[7], 14, TWO_PI / 4.6, 1);
    moons[4] = new CelestialBody(9, colors[8], 8, TWO_PI / 2.8, 0);
    moons[5] = new CelestialBody(10, colors[9], 4, TWO_PI / 5.0, 1);
    moons[6] = new CelestialBody(11, colors[10], 8, TWO_PI / 6.2, 0);
}

void draw()
{
    background(spaceImage); 

    // Draw sun
    pushMatrix();
    {
        translateCenter();
        ambientLight(50, 50, 50);
        lightSpecular(255, 255, 255);
        pointLight(255, 255, 255, 0, 0, 0);
        emissive(sun.getColor());
        sun.draw();
    }
    popMatrix();

    // Draw first planet
    pushMatrix();
    {
        translateCenter();
        rotateX(PI / 4);
        rotateY(-PI / 5);
        rotateZ(PI / 6);
        rotate(planets[0].angle);
        translate(width / 15, 0);
        rotate(0.2 * planets[0].angle);
        
        emissive(0);
        specular(11, 200, 54);
        shininess(20);
        planets[0].draw();
    }
    popMatrix();

    // Draw second planet
    pushMatrix();
    {
        translateCenter();
        rotateX(PI / 2);
        rotateY(PI / 8);
        rotateZ(-PI / 12);
        rotate(planets[1].angle);
        translate(width / 6, 0);
        rotateX(0.4 * planets[1].angle);
        rotateY(0.6 * planets[1].angle);
        rotateZ(0.8 * planets[1].angle);
        
        emissive(0);
        specular(186, 12, 46);
        shininess(40);
        planets[1].draw();

        // Draw first moon
        pushMatrix();
        {
            rotateX(-PI / 1);
            rotateY(PI / 2);
            rotateZ(PI / 3);
            rotate(moons[0].angle);
            translate(width / 45, 0);
            rotate(0.2 * moons[0].angle);
            
            emissive(0);
            specular(89, 125, 240);
            shininess(60);
            moons[0].draw();
        }
        popMatrix();
        
        // Draw second moon
        pushMatrix();
        {
            rotateX(PI / 5);
            rotateY(-PI / 1);
            rotateZ(PI / 4);
            rotate(moons[1].angle);
            translate(width / 35, 0);
            rotate(0.2 * moons[1].angle);
            
            emissive(0);
            specular(0, 120, 0);
            shininess(400);
            moons[1].draw();
        }
        popMatrix();
        
        // Draw third moon
        pushMatrix();
        {
            rotateX(-PI / 2);
            rotateY(-PI / 1);
            rotateZ(-PI / 2);
            rotate(moons[2].angle);
            translate(width / 25, 0);
            rotate(0.3 * moons[2].angle);
            
            emissive(0);
            specular(0, 0, 255);
            shininess(100);
            moons[2].draw();
        }
        popMatrix();
    }
    popMatrix();

    // Draw third planet
    pushMatrix();
    {
        translateCenter();
        rotateX(-PI / 2);
        rotateY(PI / 1);
        rotateZ(-PI / 2);
        rotate(planets[2].angle);
        translate(width / 4, 0);
        rotateX(0.6 * planets[2].angle);
        rotateY(0.9 * planets[2].angle);
        rotateZ(0.2 * planets[2].angle);
        
        spotLight(255, 0, 255, 0, 0, 0, 0, 1, 0, PI / 2, 100);
        emissive(0);
        specular(255, 255, 0);
        shininess(200);
        planets[2].draw();
        
        // Draw fourth moon
        pushMatrix();
        {
            rotateX(PI / 15);
            rotateY(-PI / 7);
            rotateZ(-PI / 3);
            rotate(moons[3].angle);
            translate(width / 25, 0);
            rotate(0.4 * moons[3].angle);
            
            emissive(0);
            specular(200, 0, 100);
            shininess(6);
            moons[3].draw();
        }
        popMatrix();
        
        // Draw fifth moon
        pushMatrix();
        {
            rotateX(PI / 1);
            rotateY(PI / 1);
            rotateZ(-PI / 1);
            rotate(moons[4].angle);
            translate(width / 35, 0);
            rotate(0.3 * moons[4].angle);
            
            emissive(0);
            specular(0, 0, 125);
            shininess(1000);
            moons[4].draw();
        }
        popMatrix();

        // Draw sixth moon
        pushMatrix();
        {
            rotateX(-PI / 2);
            rotateY(PI / 5);
            rotateZ(-PI / 5);
            rotate(moons[5].angle);
            translate(width / 55, 0);
            rotate(0.3 * moons[5].angle);
            
            emissive(0);
            specular(18, 102, 254);
            shininess(23);
            moons[5].draw();
        }
        popMatrix();
    }
    popMatrix();

    // Draw fourth planet
    pushMatrix();
    {
        translateCenter();
        rotateX(-PI / 20);
        rotateY(-PI / 10);
        rotateZ(-PI / 6);
        rotate(planets[3].angle);
        translate(width / 3, 0);
        rotate(0.1 * planets[3].angle);
        
        emissive(0);
        specular(64, 64, 200);
        shininess(206);
        planets[3].draw();

        pushMatrix();
        {
            rotateX(-PI / 8);
            rotateY(PI / 1);
            rotateZ(PI / 9);
            rotate(moons[6].angle);
            translate(width / 55, 0);
            rotate(0.3 * moons[6].angle);
            
            emissive(0);
            specular(165, 124, 36);
            shininess(2);
            moons[6].draw();
        }
        popMatrix();
    }
    popMatrix();

    // Update position
    for (CelestialBody planet : planets)
        planet.updateAngle();
        
    for (CelestialBody moon : moons)
        moon.updateAngle();
}

/////////////////////////////////////////////////////////////////// Variables //
color[] colors;
PImage spaceImage;

PShape deer, capsule;

int framerate = 60;

CelestialBody sun;
CelestialBody[] planets;
CelestialBody[] moons;

///////////////////////////////////////////////////////////////////// Classes //
class CelestialBody
{
    int sides;
    color bodyColor;
    float bodyScale;
    float speed;
    float angle;
    int type;

    CelestialBody(int sides,
                  color bodyColor,
                  float bodyScale,
                  float speed,
                  int type)
    {
        this.sides = sides;
        this.bodyColor = bodyColor;
        this.bodyScale = bodyScale;
        this.speed = speed;
        this.type = type;
    }
    
    color getColor()
    {
      return bodyColor;
    }

    void draw()
    {
        pushMatrix();
        {
            // beginShape();
            // {
                fill(bodyColor);

                if (type == 0)
                    sphere(bodyScale);

                if (type == 1)
                    box(bodyScale);

                if (type == 2) {
                    scale(bodyScale);
                    shape(deer, 0, 0);
                }

                if (type == 3) {
                    scale(bodyScale);
                    shape(capsule, 0, 0);
                }
                // for (int i = 0; i < sides; i++)
                //     vertex(bodyScale * cos(TWO_PI * (float)i / float(sides)),
                //            bodyScale * sin(TWO_PI * (float)i / float(sides)));
            // }
            // endShape(CLOSE);
        }
        popMatrix();
    }

    void updateAngle()
    {
        angle += speed / frameRate;
    }
}

//////////////////////////////////////////////////////////// Helper functions //
void translateCenter()
{
    translate(width / 2, height / 2);
}

////////////////////////////////////////////////////////////////////////////////
