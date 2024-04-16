module "compute" {
  source  = "app.terraform.io/margarita30062001/compute/aws"
  version = "1.0.0"

  aws_region          = "us-east-1"
  public_key_material = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC/gcwRSkBicQP5ONJ0tgS1uH9XP40TCkINF0UWTjri0cJsm+DgD0jIKGIiRl3N/dP24qgm2Q+q8FkQgXOnuD1Ybupl6R1yGVeEorrkMDFn7SCSTy9aQmIZK1yXCjmnQ1eb3tE1IVkEN6XKpyh39usvZ2/rECnT+laBI6Jk6vvBcuIAPAInP6Q54mDqotSbrbbbLZ2gXR98+5crkz/+qlJCwbmxvNftRY7hRIrNjJRywBiHL/vPhUBuvVYM5VL9GDZkkXbKCAxTPBSuwCQ5TqmzNJn1475e5/GistcSYVoXWJ33IMTu47TYQgG02byseVc8TBmNeGOiMTnZWbS3r1s7lI22wdIYiIKeJ6mYXTIt1E1TmPoUTFTSCEyO77V5edop0dW8zmHT6mo5IdFT0pO3HwVJtukQurxdGHTFc+RPTMHU+HsAzJ6DCeDLYq2Eiy72lNi8pPG1jxTL3oic4Hhasdo2Tfuhe6Cb2Q08oBZE+lpXzZuGR7lMZSdID9R498k= ec2-user@ip-172-31-35-237.ec2.internal"
  public_sg           = module.networking.public_sg
  public_subnets      = module.networking.public_subnets
}

module "networking" {
  source  = "app.terraform.io/margarita30062001/networking/aws"
  version = "1.0.0"

  access_ip  = "0.0.0.0/0"
  aws_region = "us-east-1"
}