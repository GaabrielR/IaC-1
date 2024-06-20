resource "aws_security_group" "SSH_Cluster" {
    name = "SSH_Cluster"
    vpc_id = module.vpc.vpc_id
}

resource "aws_security_group_rule" "SSH_Entrada" {
    type = "ingress"
    from_port = 22
    to_port = 22
    protocol = "tcp"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = aws_security_group.SSH_Cluster.id
}

resource "aws_security_group_rule" "SSH_Saida" {
    type = "egress"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = [ "0.0.0.0/0" ]
    security_group_id = aws_security_group.SSH_Cluster.id
}